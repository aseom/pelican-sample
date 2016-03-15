#!/usr/bin/env bash
set -o errexit
set -o verbose

GH_URL="https://${GH_TOKEN}@github.com/aseom/pelican-test.git"
COMMIT_MSG="Publish via travis - Build #${TRAVIS_BUILD_NUMBER}"

if [ "${TRAVIS_BRANCH}" != "master" ]; then exit 0; fi

git config --global user.name "aseom"
git config --global user.email "hm9599@gmail.com"
git clone -b gh-pages ${GH_URL} publish

cd publish
git rm -rf .
cp -r ../output/* .

git add -A .
git commit -m "${COMMIT_MSG}"
git push origin gh-pages
