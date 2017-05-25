# Boom

`Boom`是一个为iOS应用提供更好的弹框通知的组件库。`Boom`的弹框采用堆叠的形式。新的消息不会遮盖旧消息。并且`Boom`能够被充分的定制化以适应不同的App的界面风格。

![Sample Image](http://sdfsdf.com)

## Install



## 如何使用

```swift
class ViewController {
  var boom: Boom!
  override viewDidLoad() {
    boom = Boom(base: self)

    // a success toast
    boom.show(toast: .success, title: "I am Toast")

    // a warning snackBar
    boom.show(snackBar: .warning, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
      print("did touch")
    }))
  }
}
```

### 初始化

`Boom`在初始化的时候传入参数可以是`UIViewController`和`UIView`两个类型。

- 传入`UIViewController`: 弹框会添加到此`UIViewController`的view上面，然后根据view来计算布局宽度。
- 传入`UIView`: 弹框会添加到此`UIView`，并根据其计算布局宽度
- 出入`nil`: `Boom`会把弹框默认添加到`Application`的`keyWindow`上

> 这里推荐按照Sample里面的方式，传入`UIViewController`。不同的界面持有不同的`Boom`，这样当界面销毁时，`Boom`的相关弹框能够跟随同时被销毁。

### Toast

`Boom`提供`Toast`和`SnackBar`两种组件，用于两种不同种类的用户提示。

`Toast`的仅有【小图标】和【标题】两个元素，并且会在一定时间内自动隐藏。图标和背景都是通过`ToastStyle`来决定的，![ToastStyle](sdf)。

```swift
// 当duration传入nil，则会根据Boom默认的duration
func show(toast style: ToastStyle, title: String, duration: TimeInterval? = nil) -> CardIndex

```

### SnackBar

`SnackBar`有【关闭按钮】【标题】【操作按钮】三个元素，需要用户主动点击，不会自动隐藏。背景和文字颜色是通过`SnackBarStyle`来决定的，![SnackerStyle](sdfsdf)

```swift

func show(snackBar style: SnackBarStyle, title: String, action: Action) -> CardIndex
```

## 自定义
