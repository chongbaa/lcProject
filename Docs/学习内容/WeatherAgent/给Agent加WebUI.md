下面给你几种比较简单的方式，把你现在的 Agent 加一个 Web 界面（WebUI），从简单到稍微复杂一些排序，供你选择：

| 方案                | 难度  | 速度  | 美观度  | 推荐场景                   | 额外依赖                     |
| ----------------- | --- | --- | ---- | ---------------------- | ------------------------ |
| Gradio            | ★☆☆ | 最快  | ★★☆  | 快速演示、个人测试              | gradio                   |
| Streamlit         | ★★☆ | 很快  | ★★★  | 想要比较漂亮、想做 dashboard    | streamlit                |
| FastAPI + 简单 HTML | ★★★ | 中等  | ★★★★ | 想自己掌控界面、未来可能上线         | fastapi, uvicorn, jinja2 |
| Chainlit          | ★★☆ | 很快  | ★★★☆ | 专门为 LLM 对话/Agent 设计的界面 | chainlit                 |
下面分别给 **Gradio**、**Streamlit** 和 **Chainlit** 各一个最简洁、最容易上手的天气助手例子（都使用你原来的 get_weather 工具）：

### 1. Gradio 版本（最快上手）
```Python
import gradio as gr
import os
import requests
from dotenv import load_dotenv

load_dotenv()

def get_weather(city):
    api_key = os.getenv("OPENWEATHER_API_KEY")
    if not api_key:
        return "缺少 OPENWEATHER_API_KEY"
    
    url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&lang=zh_cn&units=metric"
    try:
        r = requests.get(url).json()
        if r.get("cod") != 200:
            return f"查询失败：{r.get('message', '未知错误')}"
        desc = r["weather"][0]["description"]
        temp = r["main"]["temp"]
        return f"{city} 当前：{desc}，{temp}°C"
    except Exception as e:
        return f"出错啦：{str(e)}"

def chat(message, history):
    if "天气" in message or "temperature" in message.lower():
        city = message.replace("天气", "").replace("怎么样", "").replace("如何", "").strip()
        if not city:
            return "请告诉我你要查哪个城市～"
        return get_weather(city)
    return "我现在主要会查天气哦～你可以问我：\n上海天气\n多伦多现在多少度\n北京天气怎么样"

demo = gr.ChatInterface(
    fn=chat,
    title="简易天气小助手",
    description="直接问城市名字+天气就行啦～",
    examples=["蒙特利尔天气", "上海现在多少度", "东京天气"],
    cache_examples=False,
)

if __name__ == "__main__":
    demo.launch()
```
![[Pasted image 20260108072328.png]]
### 2. Streamlit 版本（界面更现代、像 dashboard）

```Python
# 文件名: weather_streamlit.py
import streamlit as st
import os
import requests
from dotenv import load_dotenv

load_dotenv()

st.set_page_config(page_title="天气小助手", layout="centered")

st.title("🌤️ 天气小助手")
st.markdown("输入城市名，马上告诉你现在天气～")

city = st.text_input("你要查询的城市", placeholder="例如：蒙特利尔 / Shanghai / Tokyo")

if st.button("查天气", type="primary") or city:
    if not city:
        st.warning("请输入城市名称哦～")
    else:
        api_key = os.getenv("OPENWEATHER_API_KEY")
        if not api_key:
            st.error("缺少 OPENWEATHER_API_KEY，请检查 .env")
        else:
            url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&lang=zh_cn&units=metric"
            try:
                r = requests.get(url).json()
                if r.get("cod") != 200:
                    st.error(f"查询失败：{r.get('message', '未知错误')}")
                else:
                    desc = r["weather"][0]["description"]
                    temp = r["main"]["temp"]
                    feel = r["main"]["feels_like"]
                    st.success(f"**{city} 当前天气**")
                    st.markdown(f"**天气状况**：{desc}")
                    st.markdown(f"**当前温度**：{temp} °C")
                    st.markdown(f"**体感温度**：{feel} °C")
            except Exception as e:
                st.error(f"出错了… {str(e)}")

st.markdown("---")
st.caption("使用 OpenWeather API • 2026 • 简单演示版")
```

运行：streamlit run weather_streamlit.py
![[Pasted image 20260108072351.png]]
### 3. Chainlit 版本（最像 ChatGPT 的流式对话体验）
```Python
# 文件名: app.py
# 运行方式：chainlit run app.py -w

import chainlit as cl
import os
import requests
from dotenv import load_dotenv

load_dotenv()

@cl.on_message
async def main(message: cl.Message):
    city = message.content.strip()
    
    # 简单粗暴地认为用户输入的就是城市名（也可以加更智能的意图判断）
    api_key = os.getenv("OPENWEATHER_API_KEY")
    if not api_key:
        await cl.Message(content="缺少 OPENWEATHER_API_KEY，请检查 .env").send()
        return
    
    url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&lang=zh_cn&units=metric"
    
    msg = cl.Message(content="正在查询天气...")
    await msg.send()
    
    try:
        r = requests.get(url).json()
        if r.get("cod") != 200:
            await msg.update(content=f"查询失败：{r.get('message', '未知错误')}")
            return
            
        desc = r["weather"][0]["description"]
        temp = r["main"]["temp"]
        feel = r["main"]["feels_like"]
        
        answer = f"""**{city} 当前天气报告**
天气：{desc}
温度：{temp}°C
体感：{feel}°C
        
穿衣建议：记得根据体感添减衣物哦～ ❄️☀️"""
        
        await msg.update(content=answer)
        
    except Exception as e:
        await msg.update(content=f"抱歉，出错了…\n{str(e)}")
```

运行：
```Bash
pip install chainlit
chainlit run app.py -w
```
![[Pasted image 20260108072423.png]]

