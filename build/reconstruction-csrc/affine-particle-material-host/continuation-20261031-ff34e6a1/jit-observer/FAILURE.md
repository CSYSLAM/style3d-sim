The attempted observer rebuild mixed CUDA 12.4 API headers with CUPTI 13.2 generated API metadata.
Compilation failed on newer CUDA API types (including cudaAtomicOperation and cudaLogsCallback_t).
The subsequent diagnostic failed to load the missing shared library; its log is preserved.
The successful run used the already-shipped cupti_param_trace.so, which supports resource-module callbacks.
No compiler version or production solver was changed.
