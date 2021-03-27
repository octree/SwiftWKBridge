# SwiftWKBridge

[![Version](https://img.shields.io/cocoapods/v/SwiftWKBridge.svg?style=flat)](https://cocoapods.org/pods/SwiftWKBridge)
[![License](https://img.shields.io/cocoapods/l/SwiftWKBridge.svg?style=flat)](https://cocoapods.org/pods/SwiftWKBridge)
[![Platform](https://img.shields.io/cocoapods/p/SwiftWKBridge.svg?style=flat)](https://cocoapods.org/pods/SwiftWKBridge)



An elegant way to send message between `Swift` and `WKWebView`.

You don't need to write any javascript code.

And the web developer don't need write any extra javascript code either.

## Example



It's very easy to define a javascript function with native code

```swift
let plg: (String) -> Void = {
	print("🌏 [WebView]:", $0)
 }
// the first arg is the function name
webView.injector.inject(path: "window.bridge.log", plugin: plg)
// the web developer can invoke this function directly
// window.bridge.log("hello world");
```



define a function with callbacks

```swift
let plg: (String, Callback) -> Void = {
    $1("Got it. ", $0)
}
// Subscripts is supported
webView.injector["window.bridge.test"] = plg
// js: window.bridge.test("message", console.log)
```



Codable 

```Swift
struct User: Codable {
    var name: String
    var age: Int
    var nickname: String?
}

let plg: (User, Callback) -> Void = { user, callback in
    var user = user
    user.nickname = "Nickname"
    user.age = 10
    callback(user)
}

webView.injector["window.bridge.test"] = plg

// window.bridge.test({ name: "Octree", age: 100 }, (user) => { /* ... */ })
```





### CSS Injector

Besides, you can inject css into your webView

```swift
webView.injector.cssInjector.inject(css: source, forKey: key)
// remove css
webView.injector.cssInjector.removeCSS(forKey: key)
```



### Night Mode

```swift
webView.nightFall()
webView.sunrise()
```



## Installation

### CocoaPods

```ruby
pod 'SwiftWKBridge'
```

### Swift Package Manager
* File > Swift Packages > Add Package Dependency
* Add https://github.com/octree/SwiftWKBridge.git
* Select "Up to Next Major" with "1.0.0"

## Author

Octree, fouljz@gmail.com

## License

SwiftWKBridge is available under the MIT license. See the LICENSE file for more info.
