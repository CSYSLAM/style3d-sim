"""Build an isolated observer that reads only active SurfaceContactView records on each call."""
from pathlib import Path
import hashlib,json,subprocess
base=Path(__file__).resolve().parent
root=Path.cwd()
output=base/'dynamic-surface-hook'
output.mkdir(exist_ok=False)
original=root/'reconstruction/diagnostics/cudahook.c'
text=original.read_text()
for pointer_type,copy_expr in [('void *','cuMemcpy'),('CUdeviceptr','driver')]:
 anchor=('        void *ptr; memcpy(&ptr, (const char *)args[arg] + offset, 8);' if pointer_type=='void *' else
         '        CUdeviceptr ptr; memcpy(&ptr, (const char *)args[arg] + offset, 8);')
 assert text.count(anchor)==1
 # Both paths already synchronize before reading their payloads. This only changes the six contact-array lengths.
 extra="""
        if (arg == 0 && strstr(key, "30evaluate_surface_contact_force") &&
            (offset == 16 || offset == 24 || offset == 32 || offset == 40 || offset == 48 || offset == 56)) {
            int active = 0;
            size_t capacity = 0;
            memcpy(&capacity, (const char *)args[0] + 8, 8);
READER
            if (active < 0 || (size_t)active > capacity || active > 1000000) abort();
            bytes = (size_t)active * (offset == 32 ? 4 : 12);
        }
"""
 if copy_expr=='driver':
  reader="""            CUdeviceptr counter; memcpy(&counter, args[0], 8);
            if (copy(&active, counter, 4) != CUDA_SUCCESS) abort();"""
 else:
  reader="""            void *counter; memcpy(&counter, args[0], 8);
            cudaError_t (*read_count)(void *, const void *, size_t, enum cudaMemcpyKind) =
                dlsym(RTLD_NEXT, "cudaMemcpy");
            if (!read_count || read_count(&active, counter, 4, cudaMemcpyDeviceToHost) != cudaSuccess) abort();"""
 text=text.replace(anchor,anchor+extra.replace('READER',reader))
source=output/'cudahook-dynamic.c';source.write_text(text)
command=['cc','-shared','-fPIC','-O2','-Ibuild/toolchains/cuda-12.4/include',str(source),
         '-o',str(output/'cudahook.so'),'-ldl']
(output/'build.command.json').write_text(json.dumps(command,indent=2)+'\n')
with (output/'build.log').open('w') as log:
 subprocess.run(command,check=True,stdout=log,stderr=subprocess.STDOUT)
report={'original_hook_modified':False,'production_modified':False,'only_active_contact_records_read':True,
        'sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in
                  [Path(__file__),original,source,output/'cudahook.so']}}
(output/'report.json').write_text(json.dumps(report,indent=2)+'\n')
print(report)
