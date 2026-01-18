import requests
import os
from myapp.config import OPENWEATHER_API_KEY
from myapp.models.base import WeatherResponse
from dotenv import load_dotenv

load_dotenv() # 加载 .env 文件

api_key = os.getenv("OPENWEATHER_API_KEY") 
if not api_key: 
    raise ValueError("未找到 OPENWEATHER_API_KEY，请检查 .env 文件是否正确设置")

def get_weather(city: str) -> str:
    # api_key = "你的API_KEY"  # ← 替换成你自己的 key
    url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric&lang=zh_cn"

    try:
        response = requests.get(url, timeout=5)
        data = response.json()

        # 🧪 打印调试信息
        print("🦊 API 返回数据：", data)

        # 🛡️ 错误处理
        if response.status_code != 200 or "main" not in data:
            return f"无法获取 {city} 的天气信息：{data.get('message', '未知错误')}"

        temperature = data["main"]["temp"]
        description = data["weather"][0]["description"]
        return f"{city} 当前温度为 {temperature}°C，天气：{description}"

    except Exception as e:
        return f"请求天气信息时出错：{str(e)}"
