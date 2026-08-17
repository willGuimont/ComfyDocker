#!/bin/bash
set -e

# Use uv pip if uv is installed, otherwise fallback to pip
if command -v uv &> /dev/null; then
    PIP_CMD="uv pip"
else
    if [ -f "venv/bin/activate" ]; then
        source venv/bin/activate
    fi
    PIP_CMD="pip"
fi

$PIP_CMD install torch torchvision torchaudio xformers

# Install plugins
cd custom_nodes/
git clone https://github.com/ltdrdata/ComfyUI-Manager
git clone https://github.com/Fannovel16/comfyui_controlnet_aux
git clone https://github.com/Stability-AI/stability-ComfyUI-nodes
git clone https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes
git clone https://github.com/EllangoK/ComfyUI-post-processing-nodes
git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
git clone https://github.com/LucianoCirino/efficiency-nodes-comfyui

$PIP_CMD install -r ComfyUI-Manager/requirements.txt
$PIP_CMD install -r comfyui_controlnet_aux/requirements.txt
$PIP_CMD install -r stability-ComfyUI-nodes/requirements.txt
$PIP_CMD install -r efficiency-nodes-comfyui/requirements.txt
