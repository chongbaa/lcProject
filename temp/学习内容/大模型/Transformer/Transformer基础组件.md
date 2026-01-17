# 🧠 **严格版：Transformer 内部组件全集（最权威版本）**

下面这份是**纯 Transformer 架构**的组成部分，不包含任何扩散模型或其他架构的内容。

我把它分成 4 层结构，让你一眼看懂。

# 🧱 **第 1 层：输入层（Embedding Layer）**

### 1. Token Embedding

把 token → 向量。

### 2. Positional Encoding

告诉模型顺序信息。

常见类型：

- Sinusoidal（原版 Transformer）
    
- Learned Position Embedding（BERT）
    
- RoPE（LLaMA、Qwen）
    
- ALiBi（LLAMA2 可选）
    

# 🧱 **第 2 层：Transformer Block（核心）**

每一层 Transformer Block 都包含两个子层：

代码

```
[Attention 子层] → [MLP 子层]
```

每个子层都包裹 Residual + Norm。

## 🔷 **Attention 子层（Self-Attention 或 Cross-Attention）**

### 3. Q/K/V Projection（线性层）

- Q = Query
    
- K = Key
    
- V = Value
    

### 4. Scaled Dot-Product Attention

核心公式：

softmax(QKT/d)V

### 5. Multi-Head Attention

把注意力分成多个头。

### 6. Output Projection

把多头拼接后再线性变换。

## 🔷 **MLP 子层（Feed Forward Network）**

### 7. Linear → Activation → Linear

激活函数可能是：

- GELU（BERT、GPT）
    
- SwiGLU（LLaMA、Qwen）
    
- ReLU（老模型）
    

MLP 占 Transformer 参数量的 60%–70%。

## 🔷 **Block 内的辅助组件**

### 8. Residual Connection

`x + sublayer(x)`

### 9. LayerNorm 或 RMSNorm

Transformer 稳定训练的关键。

# 🧱 **第 3 层：输出层（Head）**

根据任务不同：

### 10. LM Head（语言模型头）

用于 LLM：

代码

```
Linear(hidden → vocab_size)
```

### 11. Classification Head

用于分类任务。

### 12. Projection Head

用于多模态（CLIP）。

# 🧱 **第 4 层：现代 Transformer 的增强组件（可选）**

这些不是原版 Transformer，但现代模型常用：

### 13. RoPE（旋转位置编码）

LLaMA、Qwen 的核心。

### 14. KV Cache

加速推理。

### 15. FlashAttention

加速注意力计算。

### 16. MoE（Mixture of Experts）

Mixtral、DeepSeek 的关键。

# 🎯 **严格版 Transformer 组件总表（你要的“不会混淆”的版本）**

代码

```
输入层：
- Token Embedding
- Positional Encoding（Sinusoidal / Learned / RoPE / ALiBi）

Transformer Block：
- Multi-Head Attention
  - Q/K/V Projection
  - Scaled Dot-Product Attention
  - Multi-Head concat + Output Projection
- Residual Connection
- LayerNorm / RMSNorm
- MLP（FFN）
  - Linear → Activation → Linear

输出层：
- LM Head
- Classification Head
- Projection Head

增强组件（可选）：
- RoPE
- KV Cache
- FlashAttention
- MoE
```

这份就是**纯 Transformer 架构的完整组件列表**，不会混入扩散模型、视频模型、CNN 等其他体系。