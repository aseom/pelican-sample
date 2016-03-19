#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o verbose

DEPLOY_REPO="git@github.com:aseom/pelican-sample.git"
DEPLOY_BRANCH="gh-pages"

# Ensure it is master branch
if [ "${TRAVIS_BRANCH}" != "master" ]; then exit 1; fi

# Add ssh private key for deploy
openssl aes-256-cbc -d -in deploy_key.enc -out deploy_key -K ${DEPLOY_KEY_K} -iv ${DEPLOY_KEY_IV}
chmod 600 deploy_key
eval "ssh-agent -s"
ssh-add deploy_key

# Clone deploy branch    
git clone --depth=5 --branch=${DEPLOY_BRANCH} ${DEPLOY_REPO} deploy
cd deploy

git rm -rf --quiet .
cp -r ../output/* .
# Prevent fail with "nothing to commit"
echo "#${TRAVIS_BUILD_NUMBER}" > .travis_build

git add -A .
git config user.name "aseom-travis"
git config user.email "hm9599@gmail.com"
git commit -m "Publish via travis - Build #${TRAVIS_BUILD_NUMBER}"
git push origin gh-pages
