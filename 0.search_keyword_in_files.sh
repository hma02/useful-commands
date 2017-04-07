
# example: search recursively (-r) in files (-F) for string "CudaNdarray_As_Buffer", the search includes only files with name "cuda_ndarray.cu" 
grep -r -F 'CudaNdarray_As_Buffer' --include="cuda_ndarray.cu" .