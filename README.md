<div align="center">

<h1 style="font-size:3em;">IMPROVED BUN</h1>
<h4><em>It's basically <code>oven/bun:latest</code>, with a bunch of tools like yt-dlp, FFmpeg and audio, video and image processing tools :)</em></h4>

<br>

[![Docker Image](https://img.shields.io/docker/v/simstosh/improved-bun?sort=semver&logo=docker)](https://hub.docker.com/r/simstosh/improved-bun)
[![GitHub](https://img.shields.io/badge/source-GitHub-181717?logo=github)](https://github.com/SimStm/improved-bun)
[![Platforms](https://img.shields.io/badge/platform-linux%2Famd64%20%7C%20linux%2Farm64-blue)](#english)
[![Base](https://img.shields.io/badge/base-oven%2Fbun%3Alatest-555?logo=docker)](https://hub.docker.com/r/oven/bun)


<strong>Source code:</strong> <a href="https://github.com/SimStm/improved-bun">github.com/SimStm/improved-bun</a>
<br>
<strong>Language / Idioma:</strong> <a href="#english">🇺🇸 English</a> &nbsp;·&nbsp; <a href="#portuguese">🇧🇷 Português</a>

</div>

<a id="english"></a>

## 🇺🇸 English

> Docker image based on [oven/bun](https://hub.docker.com/r/oven/bun) with Python, FFmpeg, yt-dlp, WebP tooling, and Microsoft Core Fonts pre-installed—so you don’t have to install them on every machine or CI run.

### What is it?

A **Debian-based** image (inherited from `oven/bun:latest`) extended with system packages and Python wheels commonly needed by Bun projects that touch media, downloads, or server-side rendering (Cairo/Pango).

### Image details

| Item | Value |
|------|--------|
| **Source repository** | [SimStm/improved-bun on GitHub](https://github.com/SimStm/improved-bun) |
| **Base image** | [`oven/bun:latest`](https://hub.docker.com/r/oven/bun) (tracks the official Bun release channel) |
| **Default shell / CMD** | `/bin/bash` |
| **Working directory** | `/app` |
| **Runtime user** | `app` (non-root), UID **1000**, groups `audio`, `video` |
| **Timezone** | `America/Sao_Paulo` |
| **Architectures** | `linux/amd64`, `linux/arm64` (multi-arch manifest on Docker Hub) |

The Dockerfile installs **APT** packages (curl, Python 3, FFmpeg, WebP, Cairo/Pango/Rsvg dev headers, fonts tooling, wget, cabextract, etc.), **Microsoft Core Fonts** via `ttf-mscorefonts-installer`, and **yt-dlp** via `pip3` (`--break-system-packages` on the base Python).

### Versioning & tags

| Tag pattern | Meaning |
|-------------|---------|
| `simstosh/improved-bun:latest` | Always the **most recent** successful build pushed from `main` |
| `simstosh/improved-bun:vYYYYMMDD.HHMMSS` | **Immutable** build identifier (UTC timestamp from CI), useful to pin deployments |

**Upstream tracking:** The image is built `FROM oven/bun:latest`. When the [official Bun image](https://hub.docker.com/r/oven/bun) publishes a new digest for `latest`, a scheduled workflow can commit an update and trigger a rebuild so this stack stays aligned with the current Bun base.

**Pinning for reproducibility:**

- Prefer a **timestamp tag** (`v20260327.143022`) instead of `latest` in production if you need a fixed combination of Bun base + this layer set.
- You can also pin the **base** explicitly in your own Dockerfile (e.g. `FROM oven/bun:1.3.9`) and fork/adapt this Dockerfile if you need a specific Bun semver.

### Dependencies (why they’re here)

| Dependency | Typical use |
|------------|-------------|
| **Python 3** + pip | Scripts, tooling, **yt-dlp** |
| **FFmpeg** | Audio/video processing |
| **yt-dlp** | Media download (YouTube and others) |
| **WebP** (`webpmux`, `cwebp`, `dwebp`) | WebP encode/decode/mux |
| **Microsoft Core Fonts** | Arial, Times New Roman, Courier, etc. |
| **Cairo, Pango, librsvg** (+ dev headers) | Raster/vector rendering, text layout |

### Pre-installed (summary)

- `python3`, `python3-pip` · `ffmpeg` · `webp` · `build-essential` and Cairo/Pango/JPEG/GIF/Rsvg dev packages · `pkg-config` · `xfonts-utils` · `wget` · `cabextract` · `ca-certificates` · `gnupg` · `libmspack0`
- **yt-dlp** (pip)
- **Microsoft Core Fonts** (Debian `ttf-mscorefonts-installer` package)

### How to use

```bash
docker pull simstosh/improved-bun:latest

docker run -it simstosh/improved-bun:latest
```

**Dockerfile example**

```dockerfile
FROM simstosh/improved-bun:latest
WORKDIR /app
COPY . .
RUN bun install
USER app
CMD ["bun", "run", "start"]
```

### Local build & push

```bash
docker build -t simstosh/improved-bun:latest .

docker login
docker push simstosh/improved-bun:latest
```

### CI/CD (GitHub Actions)

| Trigger | Behavior |
|---------|----------|
| Push to `main` | Multi-arch build, push to Docker Hub, sync this `README.md` to the Hub **Overview** |
| `pull_request` | Build only (no push) |
| `workflow_dispatch` | Manual run (push + README sync) |
| Schedule (every 6h) | Separate workflow checks whether `oven/bun:latest` digest changed; if so, commits `.github/bun-base-digest` and pushes, which triggers the build workflow |

The digest is read from **`registry-1.docker.io`** (Registry HTTP API v2, same as `docker pull`), via the `Docker-Content-Digest` header—not from the Docker Hub web API, which can return a digest that does not match the live manifest.

**Secrets:** `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN` ([PAT](https://docs.docker.com/docker-hub/access-tokens/) with **Read, Write & Delete** for push + README API).

**Optional — `PAT_REPO` (GitHub PAT):** Pushes made with the default `GITHUB_TOKEN` **do not** trigger other workflows (see [GitHub docs](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#using-the-github_token-in-a-workflow)). The check workflow therefore either (a) checks out with `PAT_REPO` so the digest commit’s `push` triggers **Docker Image CI**, or (b) without `PAT_REPO`, runs `gh workflow run` after the push. If builds still don’t start after digest commits, add a **classic PAT** with `repo` scope or a **fine-grained PAT** with **Contents: Read and write** for this repository, as secret `PAT_REPO`.

**Docker Hub README:** After each successful push, [dockerhub-description](https://github.com/peter-evans/dockerhub-description) uploads this file (long text limit ~25 000 chars; short description ~100 chars).

---

<a id="portuguese"></a>

## 🇧🇷 Português

> Imagem Docker baseada em [oven/bun](https://hub.docker.com/r/oven/bun) com Python, FFmpeg, yt-dlp, ferramentas WebP e fontes Microsoft Core pré-instaladas—para não precisar instalar tudo isso em cada máquina ou pipeline.

### O que é?

Imagem **baseada em Debian** (herdada de `oven/bun:latest`) estendida com pacotes de sistema e wheels Python usados com frequência em projetos Bun que lidam com mídia, downloads ou renderização no servidor (Cairo/Pango).

### Detalhes da imagem

| Item | Valor |
|------|--------|
| **Repositório fonte** | [SimStm/improved-bun no GitHub](https://github.com/SimStm/improved-bun) |
| **Imagem base** | [`oven/bun:latest`](https://hub.docker.com/r/oven/bun) (acompanha o canal oficial de releases do Bun) |
| **Shell / CMD padrão** | `/bin/bash` |
| **Diretório de trabalho** | `/app` |
| **Usuário em runtime** | `app` (não root), UID **1000**, grupos `audio`, `video` |
| **Fuso horário** | `America/Sao_Paulo` |
| **Arquiteturas** | `linux/amd64`, `linux/arm64` (manifest multi-arch no Docker Hub) |

O Dockerfile instala pacotes **APT** (curl, Python 3, FFmpeg, WebP, headers dev Cairo/Pango/Rsvg, utilitários de fontes, wget, cabextract, etc.), **fontes Microsoft Core** via `ttf-mscorefonts-installer` e **yt-dlp** via `pip3` (`--break-system-packages` no Python da base).

### Versionamento e tags

| Padrão de tag | Significado |
|---------------|-------------|
| `simstosh/improved-bun:latest` | Sempre o build **mais recente** publicado a partir de `main` |
| `simstosh/improved-bun:vYYYYMMDD.HHMMSS` | Identificador **imutável** do build (timestamp UTC do CI), útil para fixar deploys |

**Rastreamento do upstream:** a imagem usa `FROM oven/bun:latest`. Quando a [imagem oficial do Bun](https://hub.docker.com/r/oven/bun) publica um novo digest para `latest`, um workflow agendado pode atualizar o commit e disparar rebuild para manter a stack alinhada à base atual do Bun.

**Reprodutibilidade:**

- Em produção, prefira uma **tag com timestamp** em vez de `latest` se precisar de uma combinação fixa de Bun + camadas desta imagem.
- Você também pode fixar a **base** no seu próprio Dockerfile (ex.: `FROM oven/bun:1.3.9`) e adaptar este Dockerfile se precisar de um semver específico do Bun.

### Dependências (para que servem)

| Dependência | Uso típico |
|-------------|------------|
| **Python 3** + pip | Scripts, ferramentas, **yt-dlp** |
| **FFmpeg** | Processamento de áudio/vídeo |
| **yt-dlp** | Download de mídia (YouTube e outros) |
| **WebP** (`webpmux`, `cwebp`, `dwebp`) | Codificar/decodificar/mux WebP |
| **Fontes Microsoft Core** | Arial, Times New Roman, Courier, etc. |
| **Cairo, Pango, librsvg** (+ headers dev) | Renderização raster/vetorial, texto |

### Conteúdo pré-instalado (resumo)

- `python3`, `python3-pip` · `ffmpeg` · `webp` · `build-essential` e pacotes dev Cairo/Pango/JPEG/GIF/Rsvg · `pkg-config` · `xfonts-utils` · `wget` · `cabextract` · `ca-certificates` · `gnupg` · `libmspack0`
- **yt-dlp** (pip)
- **Fontes Microsoft Core** (pacote Debian `ttf-mscorefonts-installer`)

### Como usar

```bash
docker pull simstosh/improved-bun:latest

docker run -it simstosh/improved-bun:latest
```

**Exemplo de Dockerfile**

```dockerfile
FROM simstosh/improved-bun:latest
WORKDIR /app
COPY . .
RUN bun install
USER app
CMD ["bun", "run", "start"]
```

### Build local e push

```bash
docker build -t simstosh/improved-bun:latest .

docker login
docker push simstosh/improved-bun:latest
```

### CI/CD (GitHub Actions)

| Gatilho | Comportamento |
|---------|----------------|
| Push em `main` | Build multi-arch, push para Docker Hub, sincroniza este `README.md` na aba **Overview** |
| `pull_request` | Apenas build (sem push) |
| `workflow_dispatch` | Execução manual (push + sync do README) |
| Agendamento (a cada 6h) | Outro workflow verifica se o digest de `oven/bun:latest` mudou; em caso positivo, faz commit em `.github/bun-base-digest` e push, disparando o workflow de build |

O digest é obtido em **`registry-1.docker.io`** (API Registry v2, a mesma do `docker pull`), pelo header `Docker-Content-Digest`—não pela API REST do Docker Hub, que pode expor digest defasado em relação ao manifest real.

**Secrets:** `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN` ([PAT](https://docs.docker.com/docker-hub/access-tokens/) com **Read, Write & Delete** para push + API do README).

**Opcional — `PAT_REPO` (PAT do GitHub):** commits feitos só com `GITHUB_TOKEN` **não** disparam outros workflows (veja [documentação do GitHub](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#using-the-github_token-in-a-workflow)). O workflow de check usa `PAT_REPO` no checkout para que o `push` do digest dispare o **Docker Image CI**, ou, sem `PAT_REPO`, roda `gh workflow run` depois do push. Se a imagem ainda não for gerada após commits de digest, crie um **PAT clássico** com escopo `repo` ou um **fine-grained** com **Contents: Read and write** neste repositório, como secret `PAT_REPO`.

**README no Docker Hub:** após cada push bem-sucedido, [dockerhub-description](https://github.com/peter-evans/dockerhub-description) envia este arquivo (texto longo ~25 000 caracteres; descrição curta ~100 caracteres).
