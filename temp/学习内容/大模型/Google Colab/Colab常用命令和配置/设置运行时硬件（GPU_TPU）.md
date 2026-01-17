手动设置：菜单 → **Runtime → Change runtime type**

- **Hardware accelerator**：选 **T4 GPU**（免费最常用）或 **A100**（Pro版）
- **Runtime shape**：High-RAM（如果内存不够）

代码检查当前硬件：
```Python
!nvidia-smi  # 查看 GPU 信息
import torch
print(f"CUDA 可用: {torch.cuda.is_available()}")
print(f"当前 GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else '无'}")
```