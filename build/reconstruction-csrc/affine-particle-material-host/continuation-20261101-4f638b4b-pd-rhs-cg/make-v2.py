"""Serialize snapshots of adjacent observed kernels; preserve the failed v1 worker and all of its inputs."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.pd_contact_rhs_capture import select_stages

original = ROOT / 'reconstruction/csrc/pd_contact_rhs_capture.py'
text = original.read_text()
changes = [
    ('        for stage in stages:\n            rank = stage[\'rank\']\n',
     '        tails = {}\n'
     '        for stage in stages:\n            rank = stage[\'rank\']\n'),
    ("            previous = ct.c_void_p(nodes[rank - 1]['handle'])\n",
     "            previous = ct.c_void_p(tails.get(rank - 1, nodes[rank - 1]['handle']))\n"),
    ("            following = ct.c_void_p(nodes[rank + 1]['handle'])\n",
     '            # Adjacent observed kernels must wait for the prior after-snapshots before their before-snapshots.\n'
     "            tails[rank] = previous.value\n"
     "            following = ct.c_void_p(nodes[rank + 1]['handle'])\n"),
]
for before, after in changes:
    assert text.count(before) == 1, before
    text = text.replace(before, after)
ast.parse(text)
assert all(len(line) <= 128 for line in text.splitlines())
observer = BASE / 'capture-observer-v2.py'
assert not observer.exists()
observer.write_text(text)
previous = BASE.parent / 'continuation-20261101-4f638b4b-pd-contact-graph'
checks = []
for worker in range(4):
    for graph in range(2):
        definition = json.loads((previous / f'definitions4-v2/{worker}/definition-{graph}/graph.json').read_text())
        ordered = linear_order(definition)[0]
        stages = select_stages(ordered)
        nodes = [{'handle': n['handle']} for n in ordered]
        edges, tails, counter = list(map(tuple, definition['edges'])), {}, 0

        def copy_after(predecessor):
            global counter
            counter += 1
            handle = -counter
            nodes.append({'handle': handle})
            edges.append((predecessor, handle))
            return handle

        for stage in stages:
            rank = stage['rank']
            tail = tails.get(rank - 1, ordered[rank - 1]['handle'])
            for binding in stage['bindings']:
                tail = copy_after(tail)
            target = stage['node']['handle']
            edges.append((tail, target))
            tail = target
            for binding in stage['bindings']:
                if binding['label'] in stage['outputs']:
                    tail = copy_after(tail)
            tails[rank] = tail
            edges.append((tail, ordered[rank + 1]['handle']))
        actual, _ = linear_order({'nodes': nodes, 'edges': edges})
        assert len(actual) == len(nodes) == 960 and len(edges) == 1139 and counter == 684
        checks.append({'worker': worker, 'graph': graph, 'unique_order': True, 'nodes': len(nodes), 'edges': len(edges)})
worker = (BASE / 'rhs-worker.py').read_text()
before = 'from reconstruction.csrc.pd_contact_rhs_capture import Observer\n'
after = ("observer_spec = importlib.util.spec_from_file_location('reconstruction.csrc.pd_rhs_capture_v2',\n"
         "                                                      BASE / 'capture-observer-v2.py')\n"
         'observer_module = importlib.util.module_from_spec(observer_spec)\n'
         'sys.modules[observer_spec.name] = observer_module\n'
         'observer_spec.loader.exec_module(observer_module)\n'
         'Observer = observer_module.Observer\n')
assert worker.count(before) == 1
worker = worker.replace(before, after)
ast.parse(worker)
(BASE / 'rhs-worker-v2.py').write_text(worker)
driver = (BASE / 'run-rhs.py').read_text()
driver = driver.replace("BASE / 'rhs-captures'", "BASE / 'rhs-captures-v2'")
driver = driver.replace('rhs-worker.py', 'rhs-worker-v2.py')
before = "paths = [Path(__file__), BASE / 'rhs-worker-v2.py', ROOT / 'reconstruction/csrc/pd_contact_rhs_capture.py',\n"
after = "paths = [Path(__file__), BASE / 'rhs-worker-v2.py', BASE / 'capture-observer-v2.py',\n"
assert driver.count(before) == 1
driver = driver.replace(before, after)
ast.parse(driver)
(BASE / 'run-rhs-v2.py').write_text(driver)
record = {'v1_observer': str(original), 'v1_sha256': hashlib.sha256(original.read_bytes()).hexdigest(),
          'v2_sha256': hashlib.sha256(observer.read_bytes()).hexdigest(), 'CPU_virtual_DAG_checks': checks,
          'v1_target_graph_launched': False, 'v1_actual_exit': 1,
          'change': 'Chain adjacent observed stages through the previous after-snapshot tail',
          'production_changed': False, 'whole_solver_complete': False}
(BASE / 'capture-revision.json').write_text(json.dumps(record, indent=2) + '\n')
print('V2:all8 symbolic graph orders checked;90 stages,684 copies;old v1 preserved')
