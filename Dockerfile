FROM oven/bun:latest AS install
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Instalar dependências do sistema
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    curl \
    python3 \
    python3-pip \
    ffmpeg \
    webp \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    pkg-config \
    xfonts-utils \
    wget \
    cabextract \
    apt-transport-https \
    ca-certificates \
    gnupg \
    libmspack0

RUN wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.8_all.deb \
    && dpkg -i ttf-mscorefonts-installer_3.8_all.deb

RUN pip3 install --break-system-packages --no-cache-dir --pre yt-dlp


RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN groupadd app && useradd -g app -s /bin/bash -G audio,video app \
    && mkdir -p /app && chown -R app:app /app

USER app
CMD ["/bin/bash"]