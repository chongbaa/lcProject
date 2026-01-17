```Python
# 先在左侧 🔑 Secrets 加一个 secret：
# Name: HF_TOKEN (全大写！)
# Value: 你的 Hugging Face Read Token (hf_ 开头)

from google.colab import userdata
from huggingface_hub import login

login(token=userdata.get('HF_TOKEN'))  # 自动登录，以后所有 HF 模型都不用再手动输入
print("Hugging Face 登录成功！")
```
**为什么这个最重要？** 所有 gated 模型（如 Flux.1-dev、SD3、Llama 3.1）都需要它。加好后永久有效
