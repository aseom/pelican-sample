#!/usr/bin/env bash
set -o errexit
set -o verbose

GH_URL="https://${GH_TOKEN}@github.com/aseom/pelican-test.git"
COMMIT_MSG="Publish via travis - Build #${TRAVIS_BUILD_NUMBER}"

git config --global user.name "aseom-travis"
git config --global user.email "nobody@travis-ci.org"

# Ensure it is master branch
if [ "${TRAVIS_BRANCH}" != "master" ]; then exit 1; fi
    
git clone --depth=5 --branch=gh-pages ${GH_URL} publish
cd publish

git rm -rf --quiet .
cp -r ../output/* .
# Prevent fail with "nothing to commit"
echo "#${TRAVIS_BUILD_NUMBER}" > .travis_build

git add -A .
git commit -m "${COMMIT_MSG}"
git push origin gh-pages
