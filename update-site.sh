
#!/bin/bash
# update-site.sh

# 1. Render Quarto
quarto render

# 2. Rebuild Sphinx
cd sphinx-src
make html
cd ..

# 3. Copy Sphinx output
rm -rf sphinx-build-output
mkdir sphinx-build-output
cp -r sphinx-src/build/html/. sphinx-build-output/

# 4. Confirm symlink exists
if [ ! -L docs/sphinx-api-website ]; then
  ln -s ../sphinx-build-output docs/sphinx-api-website
fi

# 5. Commit
git add -A docs/ sphinx-build-output
git commit -m "Update Quarto and Sphinx site"
git push

