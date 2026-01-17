2026年的视频类AIGC（文本转视频、图生视频、视频编辑/生成等）主流模型几乎全部都使用**Transformer架构**（特别是**Diffusion Transformer / DiT** 或其多模态/时空变种）作为核心骨干**。**

这已经是视频生成领域的**绝对共识和技术天花板**，跟图片（DiT）和声音（Transformer语言模型+Diffusion）的演进路径完全一致。早期依赖纯3D U-Net或RNN的视频模型在2024-2025年后基本被淘汰，现在顶级SOTA全线转向Transformer，因为它在处理**时空长序列**（多帧+高分辨率+复杂运动）、**scaling law**（越大越强）、**物理一致性**、**提示遵循**和**多模态融合**上全面碾压。

### 为什么视频AIGC现在离不开Transformer？

- 视频是**超长时空序列**（帧×高×宽×时），需要捕捉极远的跨帧依赖、物体持久性、物理规律、相机运动等。Transformer的自注意力机制天生擅长这个。
- **DiT革命从图像延伸到视频**：Sora开创性地把DiT（Diffusion Transformer）从2D patches扩展到**3D/时空patches**（spacetime patches），让视频生成像处理“长文本”一样可扩展。
- **2026年现状**：所有能生成分钟级、高清、物理真实、人物一致的视频模型，基本都基于**Diffusion Transformer** 或 **Multimodal Transformer** 变种。没有Transformer的模型，在质量、时长、一致性上跟不上。

### 主流视频AIGC模型的Transformer使用情况（2026年1月最新）

|模型/工具|是否核心使用Transformer / DiT|具体架构类型|Transformer占比 & 关键优势|
|---|---|---|---|
|OpenAI Sora (Sora 2)|是（开创者）|Diffusion Transformer (DiT) on spacetime patches|核心去噪+时空建模全Transformer，scaling law最强|
|Google Veo 3 / Veo 3.1|是|大规模多模态Diffusion Transformer|时空一致性+原生音频融合顶级，Transformer主导|
|Kling AI (Kling O1 / 2.x)|是（大量）|Diffusion Transformer (DiT) + 3D VAE + 多模态Transformer|统一多模态+物理模拟最强，Kling O1是“统一Transformer”|
|Luma Dream Machine (Ray 3+)|是|Scalable Multimodal Transformer / Universal Transformer|直接视频训练+物理准确，Transformer高效时空建模|
|Runway Gen-3 / Gen-4|是（混合重度）|Transformer-based diffusion + 时空注意力|电影级控制+一致性优秀，Transformer处理运动|
|MiniMax Hailuo / Vidu|是|DiT变种 + Noise-Aware Transformer|中文+长视频效率高，Transformer骨干|
|Pika 2.x / LTX系列|是|DiT + MoE Transformer变种|开源/高效路线，Transformer扩展性强|

一句话总结2026年视频AIGC格局： **“Transformer（尤其是DiT / Multimodal Diffusion Transformer）彻底统治视频生成”**。Sora开了头（spacetime patches + DiT），现在Kling O1、Veo 3、Luma、Runway等全在“Transformer + 时空patches + scaling”这条赛道上卷，参数越大、训练数据越多，物理真实度、运动连贯性、人物/场景一致性就越爆炸。

早期U-Net或RNN路线已经过时，想做长视频（>30秒）、高保真、复杂相机运动、原生音频的，基本只能靠Transformer架构。