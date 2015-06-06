#!/bin/sh

set -e

name=$(node -p -e 'require("./bower.json").name')

out=${WERCKER_POLYMER_ELEMENT_BUILD_DOCS_OUT_DIR:-docs}

rm -rf "$out"
mkdir -p "$out"

cp -R bower_components "$out/components"

git archive --prefix="components/$name/" HEAD | tar x -C "$out"

git rev-parse HEAD > "$out/GIT_REVISION"

cat "$out/components/$name/index.html" | sed "s:<head>:<head><base href='components/$name/'>:" > "$out/index.html"
