#!/bin/bash
set -e

cd /workspace

echo "Starting FileBrowser..."
filebrowser \
  --address 0.0.0.0 \
  --port 8080 \
  --root /workspace \
  --noauth &

echo "Starting JupyterLab..."
jupyter lab \
  --ip=0.0.0.0 \
  --port=8888 \
  --allow-root \
  --no-browser \
  --ServerApp.token='' \
  --ServerApp.password='' &

if [ ! -d "/workspace/stable-diffusion-webui" ]; then
  echo "A1111 not found. Cloning..."
  git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /workspace/stable-diffusion-webui
  cd /workspace/stable-diffusion-webui
  git checkout v1.10.1
else
  echo "A1111 already exists."
fi

cd /workspace/stable-diffusion-webui

mkdir -p /workspace/stable-diffusion-webui/repositories

if [ ! -d "/workspace/stable-diffusion-webui/repositories/stable-diffusion-stability-ai" ]; then
  git clone https://github.com/CompVis/stable-diffusion.git \
    /workspace/stable-diffusion-webui/repositories/stable-diffusion-stability-ai
fi

# python3.11 launch.py \
#   --listen \
#   --port 7860 \
#   --api \
#   --enable-insecure-extension-access \
#   --skip-torch-cuda-test \
#   --skip-python-version-check \
#   --opt-sdp-attention \
#   --no-half-vae \
#   --no-download-sd-model \
#   --models-dir /workspace/models \
#   --ckpt-dir /workspace/models/Stable-diffusion \
#   --vae-dir /workspace/models/VAE \
#   --embeddings-dir /workspace/embeddings \
#   --gradio-allowed-path /workspace

echo "Debug mode"
tail -f /dev/null
