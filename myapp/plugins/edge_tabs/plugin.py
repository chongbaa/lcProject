from langchain_core.tools import tool

@tool
def get_current_tab() -> str:
    tabs = [
        {"pageTitle": "weather_agent 项目主页", "pageUrl": "https://github.com/yourname/weather_agent", "isCurrent": True},
        {"pageTitle": "OpenWeatherMap", "pageUrl": "https://openweathermap.org/", "isCurrent": False}
    ]
    current = next((tab for tab in tabs if tab["isCurrent"]), None)
    if current:
        return f"你当前正在浏览：{current['pageTitle']}（{current['pageUrl']}）"
    return "未找到当前标签页"
