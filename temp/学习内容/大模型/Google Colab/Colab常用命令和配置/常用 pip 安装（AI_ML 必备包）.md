```Python
!pip install -q --upgrade \
    diffusers transformers accelerate \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 \
    huggingface_hub gradio pillow opencv-python
print("常用 AI 包安装完成！")
```

- cu121 是当前主流 CUDA 版本（Colab T4/A100 支持）。
- 如果用 Flux 等大模型，加 bitsandbytes 支持量化（省显存）：
  ```Python
    !pip install -q bitsandbytes
    ```