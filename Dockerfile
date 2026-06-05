FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    wget \
    curl \
    build-essential \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN python3.11 --version

RUN python3.11 -m pip install --upgrade pip setuptools wheel

RUN python3.11 -m pip install \
    torch==2.9.1 \
    torchvision \
    torchaudio \
    --index-url https://download.pytorch.org/whl/cu128

RUN python3.11 -c "import torch; print('Torch:', torch.__version__); print('CUDA:', torch.version.cuda)"

RUN python3.11 -m pip install xformers

RUN python3.11 -c "import xformers; print('xformers installed')"

RUN python3.11 -m pip install jupyterlab

RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

RUN filebrowser version

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /workspace/stable-diffusion-webui

WORKDIR /workspace/stable-diffusion-webui

RUN git checkout v1.10.1

WORKDIR /workspace
