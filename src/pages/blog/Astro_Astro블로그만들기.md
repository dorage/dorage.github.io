---
layout: '../../layouts/BlogPost.astro'
title: 'Github Pages 개발 블로그 만들기'
stack: 'Astro'
description: ''
pubDate: 'Nov 11 2022'
heroImage: '/images/placeholder/react.jpg'
tags: ['Astro']
hide: true
---

## Astro란?

컨텐트 지향적인 웹사이트를 빠르게 빌드해주는 올인원 웹 프레임워크이다.

## Astro를 선택한 이유

선택을 할 때 가장 중점 있게 보았던 부분은 SEO + JS기반 + 무료 + 편리한 컨텐츠 작성 환경 이다.

기존에 쓰던 노션은 사용하기에는 편리했지만 SEO 부분에서 상당히 큰 손해가 있었다.

실제로 검색에 하나도 걸리지 않았을거라고 본다.

SEO를 중요하게 생각한 이유는 피드백이다.

내가 공부한 내용 중 내가 잘못 이해한 부분들도 있을 것이고, 사람들이 내게 질문을 던지면서 나도 그에 대한 공부를 할 수 있을 것이라는 생각이 문득 들었다.

또한, 무료여야 한다는 점이 중요했다.

굳이 블로그 하는데 돈을 쓰고 싶지 않았다.

그래서 여러 CMS나 다양한 잼스택 프레임워크들을 찾아보게 되었다.

최종 후보는 11ty 와 Astro 였는데, 11ty를 포기한 이유는 Github Page에 푸쉬하고 빌드하는 과정이 지속적으로 실패했기 때문이다.

더욱이나 Astro는 Github 워크플로우 액션을 등록해놓았다.

그래서 빠르게 Astro로 구축하여 공식 Document를 따라하니 손쉽게 블로그를 만들 수 있었다.

## Astro 배포하기

1. <mark>astro.config.mjs</mark> 파일의 site, base 다음과 같이 수정하기

```mjs
import { defineConfig } from 'astro/config';

export default defineConfig({
    site: 'https://{USER_NAME}.github.io', // 자신의 깃허브
    base: '/', // base
});
```

2. 프로젝트 내에 <mark>.github/workflows/deploy.yml</mark> 디렉터리 및 파일 생성

```yml
name: Github Pages Astro CI

on:
    # Trigger the workflow every time you push to the `main` branch
    # Using a different branch name? Replace `main` with your branch’s name
    push:
        branches: [main]
    # Allows you to run this workflow manually from the Actions tab on GitHub.
    workflow_dispatch:

# Allow this job to clone the repo and create a page deployment
permissions:
    contents: read
    pages: write
    id-token: write

jobs:
    build:
        runs-on: ubuntu-latest
        steps:
            - name: Checkout your repository using git
              uses: actions/checkout@v2
            - name: Install, build, and upload your site
              uses: withastro/action@v0
              # with:
              # path: . # The root location of your Astro project inside the repository. (optional)
              # node-version: 16 # The specific version of Node that should be used to build your site. Defaults to 16. (optional)
              # package-manager: yarn # The Node package manager that should be used to install dependencies and build your site. Automatically detected based on your lockfile. (optional)

    deploy:
        needs: build
        runs-on: ubuntu-latest
        environment:
            name: github-pages
            url: ${{ steps.deployment.outputs.page_url }}
        steps:
            - name: Deploy to GitHub Pages
              id: deployment
              uses: actions/deploy-pages@v1
```

3. 깃허브에 <mark>{USER_NAME}.github.io</mark> 리포지토리를 만들기

4. Settings tab 에 Pages 설정으로 이동

5. Build and deployment 설정에 Source를 Github Actions 로 변경하고 Save

6. 로컬 프로젝트틀 깃허브에 푸쉬하기
