
以下是根据来源整理的声音 AIGC 所涉及的主要模型架构：

### 1. Transformer 架构的应用

在语音合成（TTS）领域，**FastSpeech** 是基于 Transformer 架构的典型代表。相比早期的模型，它通过并行化生成声学特征，使得合成速度得到了极大的提升（比 Tacotron 快 270 倍）。此外，由于 Transformer 在自然语言处理领域的成功，目前的 AIGC 应用也正趋向于统一使用 **LLM（大语言模型）架构**。

### 2. 非 Transformer 的主流框架

除了 Transformer，声音 AIGC 还在广泛使用以下几种技术框架：

- **CNN（卷积神经网络）**：DeepMind 提出的 **WaveNet** 模型是语音生成领域的里程碑，它是一种用于生成原始音频波形的深度神经网络。
- **GAN（生成对抗网络）**：常用于声码器（Vocoder）环节，例如 **MelGAN** 和 **HiFi-GAN**。HiFi-GAN 通过多个子鉴别器并行处理周期信号，兼顾了合成质量与效率。
- **扩散模型（Diffusion Model）**：近年来，扩散模型也从图像领域迁移到了声音领域，例如 **FastDiff-TTS** 成功将其应用于语音合成。
- **RNN/LSTM（循环神经网络/长短期记忆网络）**：早期的端到端语音合成模型常采用此类架构，虽然它们现在逐渐被 Transformer 取代，但在处理时序任务方面曾是主流。
- **VAE（变分自编码器）**：常用于音乐合成及风格迁移领域。

### 3. 早期及辅助系统

- **规则系统**：利用数字信号处理技术（如正弦波、滤波器）来生成声音，虽然局限性大，但在某些特殊情况下仍作为辅助方案。
- **语音拼接系统**：不进行参数化，而是直接从数据库中挑选合适的语音片段进行拼接，这是早期商业化应用中为保证自然度常用的方法。

**总结**： 声音 AIGC 的技术路线非常多元。虽然 **Transformer** 凭借并行计算和捕捉长距离依赖的能力在现代大型语音模型中占据主导地位，但 **CNN (WaveNet)**、**GAN (HiFi-GAN)** 和 **扩散模型** 在波形生成和效率优化方面依然发挥着不可替代的作用。

**比喻理解**： 如果把声音 AIGC 比作**制作交响乐**：**Transformer** 就像是一位能瞬间看完所有乐谱并协调各乐器声部的**总指挥**；**CNN/WaveNet** 则是精雕细琢每个音符物理振动的**乐器制作工匠**；而 **GAN** 则是负责校准音色、让声音听起来更像真人的**高级音响师**。它们各司其职，并不只靠一位“指挥”包打天下。

### 4. Grok搜索2026年最新情况

2026年主流的声音AIGC（TTS + 声音克隆）模型几乎全部都**大量使用**或**完全基于Transformer架构**（或其变种），这是目前声音生成领域的绝对主流技术路线。

简单总结一下你之前提到的那些工具里Transformer的使用情况（基于最新公开信息和技术报告）：

|工具/模型|是否用Transformer|具体架构特点|Transformer占比/角色|
|---|---|---|---|
|ElevenLabs|是（核心使用）|混合了Transformer + GAN等技术，官方未完全公开，但多处证据指向Transformer骨干|非常高（主干网络）|
|Fish Audio (Fish-Speech/S1)|是（大量使用）|**Dual-AR**（快慢双Transformer）架构，Slow Transformer做语言/韵律，Fast Transformer做声学细节|几乎全部核心部分都是Transformer|
|CosyVoice 2/3|是（大量使用）|LLM骨干（基于Qwen等预训练Transformer）+ Diffusion Transformer (DiT) / Flow Matching|Transformer是主干 + 扩散部分也用DiT|
|GPT-SoVITS|是（核心使用）|GPT部分就是**纯Transformer**（类GPT结构），SoVITS部分也有Transformer Flow等|GPT阶段完全是Transformer|
|微软VALL-E X / Azure TTS|是|经典的Transformer语言模型 + 离散codec|高（语言建模核心）|
|魔音工坊 / MiniMax TTS|极大概率是|大厂商业模型，几乎100%都会用Transformer大模型路线|基本可以认为用了|
|百度文心 / 火山奇美拉|是|基于文心大模型（Transformer）+ TTS专用头|高|

### 为什么现在几乎都离不开Transformer？

- **序列建模能力超强**：语音本质上是长序列（文本+声学特征），Transformer的自注意力机制特别适合捕捉长距离依赖和韵律关系
- **可扩展性极好**：参数量做大后（几亿→几十亿），自然度、零样本克隆、多语言能力都会指数级提升
- **统一建模范式**：现在很多模型都走“**LLM + 离散语音token**”路线，把TTS变成一个条件语言生成任务（典型代表：VALL-E → Fish → CosyVoice → 各种SOTA开源）
- 替代方案（如纯RNN、Conformer早期很火）在2024年后基本被淘汰了，效率和质量都追不上

一句话总结： **2026年的顶级声音AIGC，基本可以一句话概括——“Transformer说了算”**（要么是纯Transformer语言模型，要么是Diffusion Transformer，要么是混合双Transformer架构）。

如果你想追求最极致的开源可玩性，推荐优先看**Fish Audio**（双Transformer架构很创新）和**CosyVoice 3**（DiT + 大规模LLM路线），它们是目前把Transformer用得最“花里胡哨”也最强的两条技术路径。