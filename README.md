# Sample pelican blog

[![Build Status](https://travis-ci.org/aseom/pelican-sample.svg?branch=master)](https://travis-ci.org/aseom/pelican-sample)
[![Requirements Status](https://requires.io/github/aseom/pelican-sample/requirements.svg?branch=master)](https://requires.io/github/aseom/pelican-sample/requirements/?branch=master)

[GitHub Pages][]에 [Pelican][] 기반의 static site 호스팅하기

[GitHub Pages]: https://pages.github.com/
[Pelican]: http://blog.getpelican.com/

## Workflow

- 컨텐츠가 포함된 소스를 GitHub로 푸시
- Travis CI를 통해 자동으로 static site 생성
- 생성된 파일들이 `gh-pages` 브랜치로 푸시됨
- 컨텐츠가 변경될 때마다 다시 반복

## Deploy key

Travis CI를 통해 빌드된 사이트가 `gh-pages`로 푸시되려면 ssh key가 필요.

```Shell
$ ssh-keygen -t rsa -C "pelican-sample deploy key" -N "" -f deploy_key

$ openssl aes-256-cbc -in deploy_key -out deploy_key.enc -K $(openssl rand -hex 32) -iv $(openssl rand -hex 16) -p

$ travis encrypt DEPLOY_KEY_K=[생성된 key] --add
$ travis encrypt DEPLOY_KEY_IV=[생성된 iv] --add
```

public key는 _GitHub 저장소 → Settings → Deploy keys_에 추가.  
암호화된 private key인 `deploy_key.enc`만 저장소에 커밋.

`DEPLOY_KEY_K`와 `DEPLOY_KEY_IV`는 `.travis.yml`에 암호화되어 저장됨.
