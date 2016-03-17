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
