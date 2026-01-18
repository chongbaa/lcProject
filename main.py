import streamlit as st
from myapp.core.engine import build_agent

st.set_page_config(page_title="天气查询助手", page_icon="🌪️")
st.title("🌪️ 天气查询助手")

query = st.text_input("请输入你的天气问题：")

if st.button("发送"):
    if query.strip():
        agent = build_agent()
        result = agent.invoke(
            {"messages": [("user", query)]},
            config={"configurable": {"thread_id": "webui"}}
        )
        st.success(result["messages"][-1].content)
    else:
        st.warning("请输入内容")
