```python
from xxx import yyy
│
├── 解析 xxx
│     ├── 包（文件夹 + __init__.py）
│     ├── 模块（xxx.py）
│     └── 子包（包内文件夹 + __init__.py））
│
├── 在 sys.path 中查找 xxx
│
├── 加载 xxx（若首次加载）
│     └── 执行模块代码 → 缓存到 sys.modules
│
└── 在 xxx 的命名空间中查找 yyy
      ├── 函数
      ├── 类
      ├── 变量
      ├── 子模块
      ├── 子包
      └── __all__ 中的名字
```
