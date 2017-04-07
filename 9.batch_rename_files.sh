find . -type f -name "*.pdf" -exec sh -c 'f="{}" ; mv "$f" prependstr${f:94}' \;
