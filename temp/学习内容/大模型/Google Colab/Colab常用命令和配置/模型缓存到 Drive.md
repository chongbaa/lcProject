```Python
# Flux/SDXL 等大模型缓存到 Drive（第一次慢，以后秒开）
cache_dir = "/content/drive/MyDrive/hf_cache"

from diffusers import FluxPipeline
pipe = FluxPipeline.from_pretrained(
    "black-forest-labs/FLUX.1-dev",
    torch_dtype=torch.bfloat16,
    cache_dir=cache_dir
)
```
