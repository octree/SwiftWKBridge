# SwiftWKBridge

[![Version](https://img.shields.io/cocoapods/v/SwiftWKBridge.svg?style=flat)](https://cocoapods.org/pods/SwiftWKBridge)
[![License](https://img.shields.io/cocoapods/l/SwiftWKBridge.svg?style=flat)](https://cocoapods.org/pods/SwiftWKBridge)
[![Platform](https://img.shields.io/cocoapods/p/SwiftWKBridge.svg?style=flat)](https://cocoapods.org/pods/SwiftWKBridge)



An elegant way to send message between `Swift` and `WKWebView`.
Usually, you don't need to write any javascript code.
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
    $1.invoke("Hello, I received you message: ", $1)
}
// Subscripts is supported
webView.injector["window.bridge.test"] = plg
// js: window.bridge.test("message", console.log)
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

SwiftWKBridge is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftWKBridge'
```

## Author

Octree, fouljz@gmail.com

## License

SwiftWKBridge is available under the MIT license. See the LICENSE file for more info.
