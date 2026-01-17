在 Python 里，**想知道你 import 进来的对象到底是什么类型**，有几种非常实用、工程师常用的方法。 你现在正在深入理解项目结构和 import 机制，这一步正好能帮你把“模块 → 对象 → 类型”这条链彻底吃透。

# 🎯 最直接的方法：用 `type()` 查看类型

假设你这样 import：
```python
from myapp.WeatherAgent import build_agent
```

你可以直接：
```python
print(type(build_agent))
```

输出可能是：
```text
<class 'function'>
```

# 🎯 方法 2：用 `dir()` 看对象有哪些属性（非常好用）
```python
import myapp.WeatherAgent as wa
print(dir(wa))
```

你会看到模块里所有可用的函数、类、变量。

# 🎯 方法 3：用 `inspect`（专业工程师最常用）
```python
import inspect
from myapp.WeatherAgent import build_agent

print(inspect.getsource(build_agent))   # 查看源码
print(inspect.signature(build_agent))   # 查看参数
print(inspect.isfunction(build_agent))  # 是否是函数
print(inspect.ismodule(build_agent))    # 是否是模块
print(inspect.isclass(build_agent))     # 是否是类
```

# 🎯 方法 4：用 `__class__`（对象实例）

如果你已经创建了对象：
```python
agent = build_agent()
print(agent.__class__)
```

输出可能是：
```text
<class 'langchain.agents.agent.AgentExecutor'>
```

# 🎯 方法 5：在交互式环境里用 `help()`
```python
from myapp.WeatherAgent import build_agent
help(build_agent)
```

会显示：

- 类型
    
- 文档
    
- 参数
    
- 返回值
    

非常适合调试。

# 🎯 方法 6：在 VS Code 里直接悬停（你现在的项目结构非常适合）

VS Code 会自动显示：

- 类型
    
- 定义位置
    
- 文档字符串
    

这对你这种工程化项目特别友好。

# 📌 最常用的组合（你可以直接复制）
```python
import inspect
from myapp.WeatherAgent import build_agent

print(type(build_agent))
print(inspect.getsource(build_agent))
print(inspect.signature(build_agent))
```

# 🧠 Bonus：如果你想知道“import 的到底是模块、类还是函数”

你可以这样判断：
```python
import inspect
import myapp.WeatherAgent as wa

print(inspect.ismodule(wa))        # True
print(inspect.isclass(wa))         # False
print(inspect.isfunction(wa))      # False
```