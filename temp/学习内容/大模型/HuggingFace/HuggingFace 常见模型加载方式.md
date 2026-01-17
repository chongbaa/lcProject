# 🧩 **一类：扩散模型（Diffusers）加载方式**

## **1. SD1.5 / SD2.x（Stable Diffusion）**
```python
from diffusers import StableDiffusionPipeline
import torch

pipe = StableDiffusionPipeline.from_pretrained(
    "模型路径或HF名称",
    torch_dtype=torch.float16
).to("cuda")
```

## **2. SDXL Base**
```python
from diffusers import StableDiffusionXLPipeline
import torch

pipe = StableDiffusionXLPipeline.from_pretrained(
    "模型路径或HF名称",
    torch_dtype=torch.float16,
    variant="fp16"
).to("cuda")
```

## **3. SDXL Refiner**
```python
from diffusers import StableDiffusionXLImg2ImgPipeline
import torch

pipe = StableDiffusionXLImg2ImgPipeline.from_pretrained(
    "模型路径或HF名称",
    torch_dtype=torch.float16,
    variant="fp16"
).to("cuda")
```

## **4. ControlNet**
```python
from diffusers import ControlNetModel, StableDiffusionControlNetPipeline
import torch

controlnet = ControlNetModel.from_pretrained("controlnet模型")
pipe = StableDiffusionControlNetPipeline.from_pretrained(
    "sd模型",
    controlnet=controlnet,
    torch_dtype=torch.float16
).to("cuda")
```

## **5. LoRA（适用于 SD1.5 / SDXL）**
```python
pipe.load_lora_weights("lora路径")
```

SDXL LoRA 也一样。

## **6. VAE**
```python
from diffusers import AutoencoderKL

vae = AutoencoderKL.from_pretrained("vae路径", torch_dtype=torch.float16)
pipe.vae = vae
```

# 🧠 **二类：大语言模型（LLM）加载方式（Transformers）**

## **1. Causal LM（LLaMA / Qwen / ChatGLM / Mistral）**
```python
from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

tokenizer = AutoTokenizer.from_pretrained("模型名称")
model = AutoModelForCausalLM.from_pretrained(
    "模型名称",
    torch_dtype=torch.float16,
    device_map="auto"
)
```

## **2. Encoder-Decoder（T5 / FLAN-T5 / BART）**
```python
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM

tokenizer = AutoTokenizer.from_pretrained("模型名称")
model = AutoModelForSeq2SeqLM.from_pretrained("模型名称")
```

## **3. Embedding 模型（BERT / RoBERTa / SentenceTransformer）**
```python
from transformers import AutoTokenizer, AutoModel

tokenizer = AutoTokenizer.from_pretrained("模型名称")
model = AutoModel.from_pretrained("模型名称")
```

# 🎨 **三类：图像模型（Vision Transformers / CLIP）**

## **1. CLIP（文本 + 图像编码器）**
```python
from transformers import CLIPProcessor, CLIPModel

processor = CLIPProcessor.from_pretrained("openai/clip-vit-large-patch14")
model = CLIPModel.from_pretrained("openai/clip-vit-large-patch14")
```

## **2. ViT / Swin / ConvNeXt**
```python
from transformers import AutoImageProcessor, AutoModel

processor = AutoImageProcessor.from_pretrained("模型名称")
model = AutoModel.from_pretrained("模型名称")
```

# 🔊 **四类：语音模型（Whisper / TTS / ASR）**

## **Whisper（语音识别）**
```python
from transformers import WhisperProcessor, WhisperForConditionalGeneration

processor = WhisperProcessor.from_pretrained("openai/whisper-small")
model = WhisperForConditionalGeneration.from_pretrained("openai/whisper-small")
```

# 🎵 **五类：音频生成（MusicGen / AudioLDM）**

## **MusicGen**
```python
from transformers import AutoProcessor, MusicgenForConditionalGeneration

processor = AutoProcessor.from_pretrained("facebook/musicgen-small")
model = MusicgenForConditionalGeneration.from_pretrained("facebook/musicgen-small")
```

# 🎥 **六类：视频模型（VideoCrafter / Zeroscope）**

## **VideoCrafter2**
```python
from diffusers import DiffusionPipeline

pipe = DiffusionPipeline.from_pretrained(
    "VideoCrafter/VideoCrafter2",
    torch_dtype=torch.float16
).to("cuda")
```

# 🧭 **如何快速判断模型属于哪一类？（最实用技巧）**

只看 3 个地方：
## **① HuggingFace 页面右侧的 Tags**

- `diffusers` → 扩散模型
    
- `transformers` → LLM / 文本模型
    
- `text-to-image` → SD
    
- `causal-lm` → LLaMA / Qwen
    
- `seq2seq` → T5
    
- `clip` → CLIP
    
- `vae` → VAE
    
- `controlnet` → ControlNet
    

## **② 看文件结构**

- 有 `unet` → 扩散模型
    
- 有 `pytorch_model.bin` → Transformers
    
- 有 `model.safetensors` → SD
    
- 有 `adapter_model.safetensors` → LoRA
    

## **③ 看 README**