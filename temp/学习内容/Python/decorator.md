```Python
`def decorator(func):`
    `def wrapper():`
        `print("装饰器开始执行")`
        `func()`
        `print("装饰器结束执行")`
    `return wrapper`

`@decorator`
`def say_hello():`
    `print("Hello, world!")`

`say_hello()`
```

```Python
def outer(n):
    def inner(x):
        return x + n
    return inner

add5 = outer(5)
print(add5(3))  # 8
```