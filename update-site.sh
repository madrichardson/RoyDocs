
#!/bin/bash
# update-site.sh

# 1. Render Quarto (this deletes docs/* — don't copy Sphinx yet!)
echo "Rendering Quarto site..."
quarto render

# 2. Add .nojekyll (must be after render to avoid deletion)
echo "Restoring .nojekyll for GitHub Pages..."
touch docs/.nojekyll

# 3. Rebuild Sphinx
echo "Rebuilding Sphinx docs..."
cd sphinx-src
make html
cd ..

# 4. Copy Sphinx output after Quarto has rendered
echo "Copying Sphinx HTML into docs/sphinx-api-website/"
rm -rf docs/sphinx-api-website
mkdir docs/sphinx-api-website
cp -r sphinx-src/build/html/. docs/sphinx-api-website/

# 5. Commit and push
echo "Committing and pushing site to GitHub..."
git add -A docs/
git commit -m "Update full site (Quarto + Sphinx + .nojekyll)"
git push
