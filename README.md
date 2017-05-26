# Boom

`Boom`是一个为iOS应用提供更好的弹框通知的组件库。`Boom`的弹框采用堆叠的形式。新的消息不会遮盖旧消息。并且`Boom`能够被充分的定制化以适应不同的App的界面风格。

![Sample Image](https://github.com/DanisFabric/InfinityImages/blob/master/boom/sample.gif)

## Requirements

- iOS8.0 +
- swift3.1

## Install

### Carthage

```ruby

github "DanisFabric/Boom"

```



## 如何使用

```swift
class ViewController {
  var boom: Boom!
  override viewDidLoad() {
    super.viewDidLoad()
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

`Boom`初始化传入参数支持以下类型：

- UIViewController: 弹框会添加到此`UIViewController`的view上面，然后根据view来计算布局宽度。
- UIView: 弹框会添加到此`UIView`，并根据其计算布局宽度
- nil: `Boom`会把弹框默认添加到`Application`的`keyWindow`上

> 推荐传入UIViewController。不同界面持有的Boom不会相互干扰，并且Boom能跟随界面同时销毁。

### Toast


`Boom`提供`Toast`和`SnackBar`两种组件，用于两种不同种类的用户提示。

`Toast`有【图标】和【标题】两个元素，并且会在一定时间内自动隐藏。通过`ToastStyle`自定义。

![](https://github.com/DanisFabric/InfinityImages/blob/master/boom/toast.png)


```swift
// 当duration传入nil，则会根据Boom默认的duration
func show(toast style: ToastStyle, title: String, duration: TimeInterval? = nil) -> CardIndex

```

### SnackBar

![](https://github.com/DanisFabric/InfinityImages/blob/master/boom/snackBar.png)

`SnackBar`有【关闭按钮】【标题】【操作按钮】三个元素，需要用户主动点击，不会自动隐藏。通过`SnackBarStyle`自定义。

```swift

func show(snackBar style: SnackBarStyle, title: String, action: Action) -> CardIndex
```

## 自定义

#### 基本属性

通过对`Appearence`的属性进行配置，能够全局影响`Boom`的显示属性。

```swift

// 圆角
Boom.Appearence.cornerRadius = 2

// 高度
Boom.Appearence.preferedHeight = 48

// 边距
Boom.Appearence.padding = UIOffset(horizontal: 16, vertical: 8)

// Toast显示时长
Boom.Appearence.duration = 2

// SnackBar 在点击操作后是否立即小时
Boom.Appearnce.autoDismissOnAction = true

// 阴影
Boom.Appearence.Shadow.isEnabled = true  
Boom.Appearence.Shadow.offset = UIOffset(horizontal: 0, vertical: 2)
Boom.Appearence.Shadow.alpha = 0.3
Boom.Appearence.Shadow.color = UIColor.black
Boom.Appearence.Shadow.radius: CGFloat = 2
Boom.Appearence.Shadow.exceptBlurBackground = true // 是否排除Blur

// 自定义Toast不同状态对应icon图片
Boom.Appearence.Icon.success = UIImage()
Boom.Appearence.Icon.warning = UIImage()
Boom.Appearence.Icon.info = UIImage()

/*
 * 自定义Background的类型
 * - color：纯色背景
 * - blur: 模糊背景
 */
Boom.Appearence.Background.success = BackgroundStyle.color(UIColor.black)
Boom.Appearence.Background.warning = BackgroundStyle.blur(.extraLight)

/*
 * 自定义【文字】和【icon】的前景色
 * - light: 白色
 * - dark: 黑色
 * - custom: 自定义颜色
 */
Boom.Appearence.Content.success = ContentStyle.light
Boom.Appearence.Content.warning = ContentStyle.custom(UIColor.red)

```

#### Offset

`offset`决定`Boom`弹框相对于界面的偏移。

boom.offset = UIOffset(horizontal: 0, vertical: 64)
