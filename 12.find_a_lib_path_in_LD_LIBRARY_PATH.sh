#!/bin/bash
IFS=:
#$1 is the library for example: libcudnn.so
for p in ${LD_LIBRARY_PATH}; do
    if [ -e ${p}/$1 ]; then
        echo ${p}
    fi
done
