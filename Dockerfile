FROM ubuntu:22.04

# Install uv binary
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Timezone & Environment variables
ENV TZ=America/Toronto \
    DEBIAN_FRONTEND=noninteractive \
    FORCE_CUDA="1" \
    TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 7.5 8.0 8.6+PTX" \
    TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    UV_SYSTEM_PYTHON=1 \
    CC=gcc \
    CXX=g++ \
    MAKEFLAGS="-j$(nproc)" \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    dotnet-sdk-8.0 \
    python3 \
    python3-dev \
    python3-venv \
    python3-pip \
    apt-transport-https \
    libgl1-mesa-glx \
    python3-opencv \
    libpng-dev \
    libjpeg-dev \
    libopenexr-dev \
    libtiff-dev \
    libwebp-dev \
    && rm -rf /var/lib/apt/lists/*

# Getting ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /app
WORKDIR /app
RUN uv pip install -r requirements.txt
COPY ./install_plugins.sh /app/

# Install plugins
RUN chmod +x /app/install_plugins.sh && /app/install_plugins.sh

# Launch ComfyUI
CMD ["python3", "main.py"]
