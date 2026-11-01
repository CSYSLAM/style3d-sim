from pathlib import Path
import gzip,hashlib,io,json,tarfile
base=Path(__file__).resolve().parent
directories=['first-step/'+side for side in ('legacy','source')]
for tag in directories:
 folder=base/tag/'actual';archive=folder.with_name('actual-content.tar.gz');rows={};blobs={};raw=0
 assert folder.is_dir()
 for p in sorted(folder.iterdir()):
  assert p.is_file() and not p.is_symlink()
  data=p.read_bytes();digest=hashlib.sha256(data).hexdigest()
  if digest in blobs:assert blobs[digest]==data
  else:blobs[digest]=data
  rows[p.name]={'bytes':len(data),'sha256':digest};raw+=len(data)
 manifest=json.dumps({'schema':1,'files':rows},sort_keys=True,indent=2).encode()+b'\n'
 if not archive.exists():
  with archive.open('wb') as output,gzip.GzipFile(filename='',fileobj=output,mode='wb',mtime=0,compresslevel=6) as packed:
   with tarfile.open(fileobj=packed,mode='w|') as tar:
    for name,data in [('files.json',manifest),*((f'blobs/{digest}',data) for digest,data in sorted(blobs.items()))]:
     info=tarfile.TarInfo(name);info.size=len(data);info.mode=0o644;tar.addfile(info,io.BytesIO(data))
 assert archive.stat().st_size<95*1024*1024
 with tarfile.open(archive,'r:gz') as tar:
  restored=json.load(tar.extractfile('files.json'));assert restored['files']==rows
  for digest,data in sorted(blobs.items()):assert tar.extractfile('blobs/'+digest).read()==data
 metadata={'schema':1,'format':'sha256-content-store-v1','archive':archive.name,
  'archive_sha256':hashlib.sha256(archive.read_bytes()).hexdigest(),'archive_bytes':archive.stat().st_size,
  'files':len(rows),'raw_bytes':raw,'unique_content_files':len(blobs),'unique_content_bytes':sum(map(len,blobs.values())),
  'relative_output_directory':'actual','all_raw_file_contents_preserved':True,'roundtrip_verified':True}
 folder.with_name('actual-archive.json').write_text(json.dumps(metadata,indent=2)+'\n')
 print(tag,'files',len(rows),'raw',raw,'unique',metadata['unique_content_bytes'],'archive',archive.stat().st_size,flush=True)
