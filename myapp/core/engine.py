from langchain.agents import create_agent
from langchain_openai import ChatOpenAI
from langgraph.checkpoint.memory import MemorySaver
from langchain_core.tools import Tool
from tools.weather_tool import get_weather
from myapp.core.registry import discover_plugins

def build_agent():
    llm = ChatOpenAI(model="gpt-4o-mini")
    memory = MemorySaver()
    base_tools = [ Tool.from_function( 
            func=get_weather, 
            name="get_weather", 
            description="根据城市名称获取天气信息" 
        ) 
    ]
    plugin_tools = discover_plugins()
    all_tools = base_tools + plugin_tools

    return create_agent(
        model=llm,
        tools=all_tools,
        system_prompt="你是 Weather Sage，一个插件式天气智能助手。",
        checkpointer=memory,
    )
