#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o verbose

PUBLISH_REPO="https://${GH_TOKEN}@github.com/aseom/pelican-sample.git"
PUBLISH_BRANCH="gh-pages"

# Ensure it is master branch
if [ "${TRAVIS_BRANCH}" != "master" ]; then exit 1; fi
    
git clone --depth=5 --branch=${PUBLISH_BRANCH} ${PUBLISH_REPO} publish
cd publish

git rm -rf --quiet .
cp -r ../output/* .
# Prevent fail with "nothing to commit"
echo "#${TRAVIS_BUILD_NUMBER}" > .travis_build

git add -A .
git config --global user.name "aseom-travis"
git config --global user.email "hm9599@gmail.com"
git commit -m "Publish via travis - Build #${TRAVIS_BUILD_NUMBER}"
git push origin gh-pages
