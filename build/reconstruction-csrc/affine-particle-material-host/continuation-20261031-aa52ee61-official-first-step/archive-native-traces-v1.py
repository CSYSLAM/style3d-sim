from pathlib import Path
import gzip,hashlib,io,json,tarfile
base=Path(__file__).resolve().parent
for tag in ('original0','source0','source1','source2','original-common0','source-common0'):
 folder=base/tag/'native';archive=folder.with_suffix('.tar.gz');rows=[];aggregate=hashlib.sha256();raw=0
 assert folder.is_dir() and not archive.exists()
 with archive.open('wb') as output,gzip.GzipFile(filename='',fileobj=output,mode='wb',mtime=0,compresslevel=6) as packed:
  with tarfile.open(fileobj=packed,mode='w|') as tar:
   for p in sorted(folder.iterdir()):
    assert p.is_file() and not p.is_symlink()
    data=p.read_bytes();digest=hashlib.sha256(data).digest()
    aggregate.update(p.name.encode()+b'\0'+len(data).to_bytes(8,'little')+digest)
    info=tarfile.TarInfo('native/'+p.name);info.size=len(data);info.mode=0o644
    tar.addfile(info,io.BytesIO(data));raw+=len(data);rows.append(p.name)
 assert archive.stat().st_size<95*1024*1024
 restored=hashlib.sha256();names=[]
 with tarfile.open(archive,'r:gz') as tar:
  for member in tar:
   assert member.isfile() and member.name.startswith('native/')
   data=tar.extractfile(member).read();name=Path(member.name).name
   restored.update(name.encode()+b'\0'+len(data).to_bytes(8,'little')+hashlib.sha256(data).digest());names.append(name)
 assert restored.hexdigest()==aggregate.hexdigest() and names==rows
 metadata={'schema':1,'archive':archive.name,'archive_sha256':hashlib.sha256(archive.read_bytes()).hexdigest(),
  'archive_bytes':archive.stat().st_size,'files':len(rows),'raw_bytes':raw,'member_aggregate_sha256':aggregate.hexdigest(),
  'aggregate_format':'sorted basename UTF8, NUL, uint64 little-endian byte length, 32-byte SHA256 digest',
  'relative_output_directory':'native','all_raw_file_contents_preserved':True,'roundtrip_verified':True}
 folder.with_name('native-archive.json').write_text(json.dumps(metadata,indent=2)+'\n')
 print(tag,'files',len(rows),'raw',raw,'archive',archive.stat().st_size,flush=True)
