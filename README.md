# ComfyUI Dockerfile

## Installation

Follow the instructions
from [Flux1 ComfyUI Guide](https://comfyui-wiki.com/tutorial/advanced/flux1-comfyui-guide-workflow-and-examples).
`./models` is a volume mapped to the container, so put the models there.

```shell
cd models/clip
wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors
wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors
wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors

cd ../vae
wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors

cd ../unet
# Normal models
wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors
# Might require to ask for access to FLUX.1-dev on Hugging Face
wget --header="Authorization: Bearer <HF_TOKEN>" https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors
# FP8 models
wget https://huggingface.co/Comfy-Org/flux1-dev/resolve/main/flux1-dev-fp8.safetensors
wget https://huggingface.co/Comfy-Org/flux1-schnell/resolve/main/flux1-schnell-fp8.safetensors
```

## Running

```shell
docker-compose up --build
```

`./output` is a volume mapped to `/app/output`, so the output will be saved there.

## Additional notes

### Useful resources

- Plugins for comfyui at [civitai](https://civitai.com/tag/comfyui), or models at [civitai](https://civitai.com/).
- [lexica](https://lexica.art/) for prompt ideas.
- Additional models and lora can be downloaded at [civitai](https://civitai.com/)

### Installing plugins

Additional plugins can be added to the `install_plugins.sh` script.
