# improved-bun

> Imagem Docker baseada em [oven/bun](https://hub.docker.com/r/oven/bun) com dependências prontas para projetos que usam Python, FFmpeg, yt-dlp, webpmux e fontes Microsoft.

[![Docker Image](https://img.shields.io/docker/v/simstosh/improved-bun?sort=semver&logo=docker)](https://hub.docker.com/r/simstosh/improved-bun)
[![Platforms](https://img.shields.io/badge/platform-linux%2Famd64%20%7C%20linux%2Farm64-blue)](#)

---

## 🇧🇷 Português

### O que é?

Imagem Docker derivada da oficial `oven/bun:latest` com ferramentas e bibliotecas pré-instaladas para evitar downloads e instalações repetidas em projetos que dependem de:

| Dependência | Uso |
|-------------|-----|
| **Python 3** + pip | Scripts Python, yt-dlp |
| **FFmpeg** | Processamento de áudio/vídeo |
| **yt-dlp** | Download de mídia (YouTube, etc.) |
| **WebP** (webpmux, cwebp, dwebp) | Manipulação de imagens WebP |
| **Fontes Microsoft** (Core Fonts) | Arial, Times New Roman, Courier, etc. |
| **Cairo, Pango, librsvg** | Renderização de gráficos e texto |

### Conteúdo pré-instalado

- `python3`, `python3-pip`
- `ffmpeg`
- `webp` (ferramentas webpmux, cwebp, dwebp)
- `build-essential`, `libcairo2-dev`, `libpango1.0-dev`, `libjpeg-dev`, `libgif-dev`, `librsvg2-dev`, `pkg-config`
- `yt-dlp` (via pip)
- Fontes Microsoft Core (ttf-mscorefonts-installer)
- Usuário não-root `app` (UID 1000) com grupos `audio` e `video`
- Fuso horário: `America/Sao_Paulo`

### Como usar

```bash
# Pull
docker pull simstosh/improved-bun:latest

# Executar shell interativo
docker run -it simstosh/improved-bun:latest

# Usar como base em seu Dockerfile
FROM simstosh/improved-bun:latest
WORKDIR /app
COPY . .
RUN bun install
CMD ["bun", "run", "start"]
```

### Build local

```bash
# Build
docker build -t simstosh/improved-bun:latest .

# Push para Docker Hub (após login)
docker push simstosh/improved-bun:latest
```

### Plataformas suportadas

- `linux/amd64` (x86_64)
- `linux/arm64` (aarch64)

---

## 🇺🇸 English

### What is it?

A Docker image derived from the official `oven/bun:latest` with pre-installed tools and libraries so you don't need to install them every time you run projects that depend on:

| Dependency | Use |
|------------|-----|
| **Python 3** + pip | Python scripts, yt-dlp |
| **FFmpeg** | Audio/video processing |
| **yt-dlp** | Media downloads (YouTube, etc.) |
| **WebP** (webpmux, cwebp, dwebp) | WebP image manipulation |
| **Microsoft Fonts** (Core Fonts) | Arial, Times New Roman, Courier, etc. |
| **Cairo, Pango, librsvg** | Graphics and text rendering |

### Pre-installed contents

- `python3`, `python3-pip`
- `ffmpeg`
- `webp` (webpmux, cwebp, dwebp tools)
- `build-essential`, `libcairo2-dev`, `libpango1.0-dev`, `libjpeg-dev`, `libgif-dev`, `librsvg2-dev`, `pkg-config`
- `yt-dlp` (via pip)
- Microsoft Core Fonts (ttf-mscorefonts-installer)
- Non-root user `app` (UID 1000) with `audio` and `video` groups
- Timezone: `America/Sao_Paulo`

### How to use

```bash
# Pull
docker pull simstosh/improved-bun:latest

# Interactive shell
docker run -it simstosh/improved-bun:latest

# Use as base in your Dockerfile
FROM simstosh/improved-bun:latest
WORKDIR /app
COPY . .
RUN bun install
CMD ["bun", "run", "start"]
```

### Local build

```bash
# Build
docker build -t simstosh/improved-bun:latest .

# Push to Docker Hub (after login)
docker push simstosh/improved-bun:latest
```

### Supported platforms

- `linux/amd64` (x86_64)
- `linux/arm64` (aarch64)

---

## 🤖 CI/CD (GitHub Actions)

### Triggers

| Evento / Event | Descrição / Description |
|----------------|--------------------------|
| `push` em `main` | Build e push para Docker Hub |
| `workflow_dispatch` | Build manual |
| `schedule` (a cada 6h) | Verifica se `oven/bun:latest` foi atualizado e dispara rebuild |

### Secrets necessários / Required secrets

- `DOCKERHUB_USERNAME` — usuário Docker Hub
- `DOCKERHUB_TOKEN` — token de acesso (não use senha)

### Tags geradas

- `simstosh/improved-bun:latest`
- `simstosh/improved-bun:YYYYMMDD.HHMMSS` (por build)

### Multi-arch

As imagens são publicadas para `linux/amd64` e `linux/arm64` automaticamente.
