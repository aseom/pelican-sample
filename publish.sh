#!/usr/bin/env bash
set -o errexit
set -o verbose

GH_URL="https://${GH_TOKEN}@github.com/aseom/pelican-test.git"
COMMIT_MSG="Publish via travis - Build #${TRAVIS_BUILD_NUMBER}"

# Ensure it is master branch
if [ "${TRAVIS_BRANCH}" != "master" ]; then exit 1; fi

git clone -b gh-pages ${GH_URL} publish
cd publish

git rm -rf --quiet .
cp -r ../output/* .
# Prevent fail with "nothing to commit"
echo "#${TRAVIS_BUILD_NUMBER}" > .travis_build

git add -A .
git commit --author="aseom <hm9599@gmail.com>" -m "${COMMIT_MSG}"
git push origin gh-pages
