#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o verbose

DEPLOY_REPO="aseom/pelican-sample"
DEPLOY_BRANCH="gh-pages"

# Ensure it is master branch
if [ "${TRAVIS_BRANCH}" != "master" ]; then exit 1; fi
    
git clone --depth=5 --branch=${DEPLOY_BRANCH} https://github.com/${DEPLOY_REPO}.git deploy
cd deploy

git config user.name "aseom-travis"
git config user.email "hm9599@gmail.com"
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" > .git/credentials

git rm -rf --quiet .
cp -r ../output/* .
# Prevent fail with "nothing to commit"
echo "#${TRAVIS_BUILD_NUMBER}" > .travis_build

git add -A .
git commit -m "Publish via travis - Build #${TRAVIS_BUILD_NUMBER}"
git push origin gh-pages
