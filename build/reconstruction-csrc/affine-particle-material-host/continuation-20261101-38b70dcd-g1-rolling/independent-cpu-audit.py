"""Recheck rolling snapshots, actual ABI relocation, every complete output and real atomic sequence from saved bytes."""
from collections import Counter, defaultdict
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

root=Path.cwd()
sys.path.insert(0,str(root))
from reconstruction.demo_ab import spread_report

base=Path(__file__).resolve().parent
plan=json.loads((base/'plan.json').read_text())
for name,sha in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest()==sha,name
assert json.loads((base/'status.json').read_text())['complete']
assert json.loads((base/'replay.status.json').read_text())=={
    'exit':0,'complete':True,'whole_solver_complete':False}
replay=json.loads((base/'replay/report.json').read_text())
assert len(replay['packets'])==240


def order(graph):
    nodes={node['handle'] for node in graph['nodes']}
    degree=dict.fromkeys(nodes,0)
    following={node:[] for node in nodes}
    for a,b in graph['edges']:
        assert a in nodes and b in nodes
        degree[b]+=1
        following[a].append(b)
    ready=[node for node in nodes if not degree[node]]
    result=[]
    while ready:
        assert len(ready)==1
        node=ready.pop()
        result.append(node)
        for target in following[node]:
            degree[target]-=1
            if not degree[target]:
                ready.append(target)
    assert len(result)==len(nodes)
    return result


def schema(key):
    # These fields are independently checked against the compiled native structure and actual 248/8 ABI.
    sizes={0:4,16:4000,24:4000,32:12000,40:12000,48:12000,56:12000,64:12000,72:4000,80:4000,
           88:420,96:420,104:2940,112:1260,120:420,128:420,136:420,144:420,
           176:176,184:704,192:528,200:1584,224:2112,232:2112}
    return {1:(1,0,2112 if key=='force' else 6336),
            **{256+offset//8:(0,offset,size) for offset,size in sizes.items()}}


def pointer(raw,spec):
    parameter,offset,_=spec
    return int.from_bytes(raw[parameter][offset:offset+8],'little')


layouts={}
for side in ('original','source'):
    folder=base/side
    old=json.loads((folder/'definition-before/graph.json').read_text())
    new=json.loads((folder/'graph-after-topology.json').read_text())
    layout=json.loads((folder/'snapshot-layout.json').read_text())
    old_order,new_order=order(old),order(new)
    assert len(old_order)==17467 and len(old['edges'])==17466
    assert len(new_order)==17519 and len(new['edges'])==17522
    edges=set(map(tuple,new['edges']))
    assert set(old_order)<=set(new_order) and set(map(tuple,old['edges']))<=edges
    originals={row['handle']:row for row in old['nodes']}
    positions={handle:i for i,handle in enumerate(new_order)}
    intervals=[]
    new_nodes=set(new_order)-set(old_order)
    assert len(layout['snapshots'])==52 and len(layout['stages'])==2
    seen=set()
    for stage in layout['stages']:
        key=stage['key']
        layouts[side,key]=stage
        expected=schema(key)
        node=stage['node']
        target=node['handle']
        assert node==originals[target] and node['name']==plan['kernels'][key]
        assert old_order.index(target)==stage['rank']==(14577 if key=='force' else 14592)
        assert node['geometry']==[4,1,1,256,1,1,0] and node['parameter_widths']==[248,8]
        assert stage['outputs']==[1]
        assert {int(i):size for i,size in stage['sizes'].items()}=={i:spec[2] for i,spec in expected.items()}
        assert {int(i):(spec['parameter'],spec['offset']) for i,spec in stage['bindings'].items()}=={
            i:spec[:2] for i,spec in expected.items()}
        raw=[bytes.fromhex(value) for value in node['parameter_hex']]
        previous,following=(old_order[stage['rank']+delta] for delta in (-1,1))
        rows=[row for row in layout['snapshots'] if row['stage']==key]
        assert {(row['phase'],row['binding']) for row in rows}=={
            *(('before',i) for i in expected),('after',1)}
        for row in rows:
            binding=row['binding']
            assert row['node'] in new_nodes and row['node'] not in seen
            seen.add(row['node'])
            assert row['source']==pointer(raw,expected[binding]) and row['bytes']==expected[binding][2]
            assert (row['predecessor'],row['node']) in edges
            if row['phase']=='before':
                assert positions[previous]<positions[row['node']]<positions[target]
            else:
                assert positions[target]<positions[row['node']]<positions[following]
            intervals.append((row['offset'],row['offset']+row['bytes']))
    assert seen==new_nodes and min(intervals)[0]==0
    assert all(a[1]==b[0] for a,b in zip(sorted(intervals),sorted(intervals)[1:]))
    assert max(intervals)[1]==layout['total_snapshot_bytes']==196776
    assert (base/(side+'-capture-as-run.py')).read_bytes()==(base/'capture-template.py').read_bytes()
assert (base/'replay-replay-as-run.py').read_bytes()==(base/'replay-template.py').read_bytes()
counts,strict,lane_counts=defaultdict(Counter),defaultdict(Counter),defaultdict(Counter)
seen=set()
for row in replay['packets']:
    key,side,frame=row['stage'],row['side'],row['frame']
    assert (key,side,frame) not in seen
    seen.add((key,side,frame))
    path=base/side/(key+'-packets')/f'frame-{frame:02d}.npz'
    assert hashlib.sha256(path.read_bytes()).hexdigest()==replay['input_sha256'][str(path)]
    expected=schema(key)
    with np.load(path) as packet,np.load(base/'replay'/f'{key}-{side}-frame-{frame:02d}.npz') as results:
        raw=[packet['parameter-'+str(i)].tobytes() for i in range(2)]
        assert [value.hex() for value in raw]==layouts[side,key]['node']['parameter_hex']
        assert list(map(len,raw))==[248,8]
        values={i:pointer(raw,spec) for i,spec in expected.items()}
        bindings={i:packet['before-binding-'+str(i)].tobytes() for i in expected}
        assert {i:len(value) for i,value in bindings.items()}=={i:spec[2] for i,spec in expected.items()}
        after=packet['after-binding-1'].tobytes()
        active=min(max(int.from_bytes(bindings[256],'little',signed=True),0),1000)
        assert active==row['active_contacts']
        assert int.from_bytes(raw[0][8:16],'little')==1000
        assert [int.from_bytes(raw[0][o:o+8],'little') for o in (152,160,168,208,216)]==[105,105,1,44,176]
        assert raw[0][240:248]==bytes.fromhex('0000b443cdcccc3d')
        counts[key]['active_contacts']+=active
        changed=int(np.count_nonzero(np.frombuffer(after,dtype='<u4')!=np.frombuffer(bindings[1],dtype='<u4')))
        assert row['capture_effective_scalars']=={'1':changed}
        counts[key]['effective_calls']+=changed>0
        relocated=[results['replay-parameter-'+str(i)].tobytes() for i in range(2)]
        assert list(map(len,relocated))==[248,8]
        scalar=np.ones(248,dtype=bool)
        for i,(parameter,offset,_) in expected.items():
            if parameter==0:
                scalar[offset:offset+8]=False
        assert np.array_equal(np.frombuffer(relocated[0],dtype='u1')[scalar],np.frombuffer(raw[0],dtype='u1')[scalar])
        counts[key]['preserved_view_scalar_bytes']+=int(scalar.sum())
        actual_pointers={i:pointer(relocated,spec) for i,spec in expected.items()}
        all_indices=[i for span in row['spans'] for i in span['indices']]
        assert len(all_indices)==len(set(all_indices)) and set(all_indices)==set(expected)
        for span in row['spans']:
            first=min(values[i] for i in span['indices'])
            for i in span['indices']:
                assert actual_pointers[i]==span['replay_base_address']+values[i]-first
                assert actual_pointers[i]%256==values[i]%256
        assert row['actual_output_replay_addresses']=={'1':actual_pointers[1]}
        for check in row['checks']:
            backend=check['backend']
            value=results[backend+'-output-1'].tobytes()
            equal=value==after
            assert check['captured_output_equal']=={'1':equal} and check['all_outputs_equal']==equal
            strict[key][backend]+=equal
            counts[key]['complete_vectors_rechecked']+=1
            for index,span in enumerate(row['spans']):
                first=min(values[i] for i in span['indices'])
                last=max(values[i]+len(bindings[i]) for i in span['indices'])
                assert last-first==span['bytes'] and first%256==span['original_start_mod256']
                padding=first%256
                before=np.zeros(padding+span['bytes'],dtype='u1')
                covered=np.zeros(len(before),dtype=bool)
                keep=np.ones(len(before),dtype=bool)
                for i in span['indices']:
                    offset=padding+values[i]-first
                    data=np.frombuffer(bindings[i],dtype='u1')
                    old=before[offset:offset+len(data)]
                    mask=covered[offset:offset+len(data)]
                    assert np.array_equal(old[mask],data[mask])
                    old[:]=data
                    covered[offset:offset+len(data)]=True
                    if i==1:
                        keep[offset:offset+len(data)]=False
                assert covered[padding:].all()
                value=results[backend+'-group-'+str(index)]
                assert np.array_equal(value[keep],before[keep]) and check['unwritten_bytes_unchanged']
                counts[key]['unwritten_after_bytes_rechecked']+=int(keep.sum())
        grouped,full={},{ }
        for backend in ('original','source'):
            sizes,records=results[backend+'-counts'],results[backend+'-records']
            assert sizes.shape==(1024,) and not sizes[active:].any() and sizes.max()<=(18 if key=='force' else 54)
            assert records.shape==(int(sizes.sum()),16)
            cursor,by_lane,ordered=0,[],[]
            for size in sizes:
                by_target,sequence=defaultdict(list),[]
                for record in records[cursor:cursor+int(size)]:
                    address=int.from_bytes(record[:8].tobytes(),'little')
                    assert actual_pointers[1]<=address<actual_pointers[1]+len(after)
                    assert (address-actual_pointers[1])%4==0
                    target=(1,(address-actual_pointers[1])//4)
                    bits=int.from_bytes(record[8:12].tobytes(),'little')
                    assert np.isfinite(np.asarray(bits,dtype='<u4').view('<f4'))
                    by_target[target].append(bits)
                    sequence.append((target,bits))
                by_lane.append(dict(by_target))
                ordered.append(sequence)
                cursor+=int(size)
            assert cursor==len(records)==row['atomic_operands'][backend]
            grouped[backend],full[backend]=by_lane,ordered
            counts[key]['real_atomic_operands_rechecked']+=len(records)
            if backend=='original':
                lane_counts[key].update(map(int,sizes[:active]))
        different=[i for i,(a,b) in enumerate(zip(grouped['original'],grouped['source'])) if a!=b]
        sequence_different=[i for i,(a,b) in enumerate(zip(full['original'],full['source'])) if a!=b]
        assert different==row['operand_differing_lanes'] and sequence_different==row['complete_sequence_differing_lanes']
        counts[key]['per_target_sequence_differing_lanes']+=len(different)
        counts[key]['full_thread_sequence_differing_lanes']+=len(sequence_different)
        counts[key]['packets']+=1
assert seen=={(k,s,i) for k in ('force','matrix') for s in ('original','source') for i in range(60)}
fixed=base.parent/'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
assert hashlib.sha256(fixed.read_bytes()).hexdigest()==json.loads((base/'status.json').read_text())['fixed_C8_report_sha256']
old_paths=json.loads(fixed.read_text())['input_npz_paths']
diagnostics={}
with ExitStack() as stack:
    originals=[stack.enter_context(np.load(old_paths['original'+str(i)])) for i in range(8)]
    for side in ('original','source'):
        runtime=json.loads((base/side/'worker/runtime.json').read_text())
        assert runtime['exit']==0 and runtime['real_graph_observed'] and runtime['public_core_abi']
        assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped']==(side=='original')
        actual=stack.enter_context(np.load(base/side/'worker/states.npz'))
        stats=spread_report(originals,[actual])
        outside={}
        for key in actual.files:
            values=np.stack([x[key].astype(np.float64) for x in originals])
            candidate=actual[key].astype(np.float64)
            assert len(candidate)==60 and np.isfinite(candidate).all()
            total=values.sum(0)
            axes=tuple(range(1,candidate.ndim))
            spread=np.maximum.reduce([np.abs(values[i]-(total-values[i])/7).max(axis=axes) for i in range(8)])
            error=np.abs(candidate-total/8).max(axis=axes)
            assert int(np.count_nonzero(error<=spread))==stats[key]['substeps_within_spread']
            assert float(error.max())==stats[key]['reconstruction_error_max']
            outside[key]={'frames':np.flatnonzero(error>spread).tolist(),'max_error':float(error.max())}
        exact={}
        for label,path in old_paths.items():
            with np.load(path) as saved:
                exact[label]=all(actual[key].tobytes()==saved[key].tobytes() for key in actual.files)
        diagnostics[side]={'statistics':stats,'outside':outside,'exact_frozen_matches':exact}
(base/'diagnostic-trajectories.json').write_text(json.dumps(diagnostics,indent=2)+'\n')
report={'counts':{key:dict(value) for key,value in counts.items()},
        'strict_vectors_of120':{key:dict(value) for key,value in strict.items()},
        'active_lane_atomic_counts':{key:dict(value) for key,value in lane_counts.items()},
        'actual_replay_ABI_pointer_fields_and_all_scalar_bytes_rechecked':True,
        'full_after_bytes_independently_rechecked':True,'fixed_C8_failure_reclassified':False,
        'whole_solver_complete':False,'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base/'independent-cpu-audit.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)
