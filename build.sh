#!/bin/bash
mkdir -p pdf
for f in source/*.typ; do
  name=$(basename "${f%.typ}")
  echo "Compiling $name..."
  typst compile "$f" "pdf/$name.pdf" --root .
done
echo "Done."