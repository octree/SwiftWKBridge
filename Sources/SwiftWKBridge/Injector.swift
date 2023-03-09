//
//  Injector.swift
//  SwiftWKBridge
//
//  Created by Octree on 2019/6/16.
//
//  Copyright (c) 2019 Octree <fouljz@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import WebKit

public class Injector: NSObject {
    private static let messageName = "bridge"
    private var pluginMap = [String: AnyPlugin]()

    /// 管理 JS 脚本
    public let userScriptManager: UserScriptManager

    /// 管理 CSS 样式
    public private(set) lazy var cssInjector: CSSInjector = {
        CSSInjector(webView: webView)
    }()

    private weak var webView: WKWebView?

    init(webView: WKWebView) {
        self.webView = webView
        userScriptManager = UserScriptManager(webView: webView)
        super.init()
        webView.configuration.userContentController.add(self, name: Self.messageName)
    }

    private func inject(script: String, key: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool = false) {
        let script = WKUserScript(source: script, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        userScriptManager.inject(script: script, forKey: key)
    }
}

extension Injector: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == Self.messageName else {
            return
        }
        guard let body = message.body as? [String: String] else {
            return
        }

        guard let identifier = body["identifier"], let args = body["args"] else {
            return
        }
        guard let plugin = pluginMap[identifier] else {
            return
        }
        plugin.invoke(argString: args)
    }
}

// MARK: - Inject Methods
public extension Injector {

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject(path: String, plugin: @escaping () -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) {
        let f: (Args0) -> Void = { _ in
            plugin()
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 0)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0>(path: String, plugin: @escaping (P0) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable {
        let f: (Args1<P0>) -> Void = {
            plugin(self.processCallback($0.arg0))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 1)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1>(path: String, plugin: @escaping (P0, P1) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable, P1: Decodable {
        let f: (Args2) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 2)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2>(path: String, plugin: @escaping (P0, P1, P2) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable, P1: Decodable, P2: Decodable {
        let f: (Args3) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 3)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3>(path: String, plugin: @escaping (P0, P1, P2, P3) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable {
        let f: (Args4) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 4)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4>(path: String, plugin: @escaping (P0, P1, P2, P3, P4) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable {
        let f: (Args5) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 5)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4, P5>(path: String, plugin: @escaping (P0, P1, P2, P3, P4, P5) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable {
        let f: (Args6) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4),
                   self.processCallback($0.arg5))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 6)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4, P5, P6>(path: String, plugin: @escaping (P0, P1, P2, P3, P4, P5, P6) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable {
        let f: (Args7) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4),
                   self.processCallback($0.arg5),
                   self.processCallback($0.arg6))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 7)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4, P5, P6, P7>(path: String, plugin: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable, P7: Decodable {
        let f: (Args8) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4),
                   self.processCallback($0.arg5),
                   self.processCallback($0.arg6),
                   self.processCallback($0.arg7))
        }
        _inject(path: path,
                plugin: f,
                injectionTime: injectionTime,
                argsCount: 8)
    }

    private func _inject<Arg: ArgsType>(path: String, plugin: @escaping (Arg) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentEnd, argsCount: Int) {
        pluginMap[path] = Plugin(webView: webView, path: path, f: plugin)
        inject(script: scriptForPlugin(withPath: path, argsCount: argsCount), key: path, injectionTime: injectionTime, forMainFrameOnly: false)
    }

    /// 删除插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    func removePlugin(forPath path: String) {
        pluginMap[path] = nil
        userScriptManager.remove(forKey: path)
    }
}

// MARK: - JS Code Generator
extension Injector {
    private func objectDefineJavascriptCode(path: String) -> String {
        return """
        if(\(path)==null){ \(path) = {} }
        """
    }

    private func functionDefineCode(path: String, argsCount: Int) -> String {
        if argsCount == 0 {
            return """
            if(globalThis.\(path)==null) { globalThis.\(path) = function() { window.__bridge__.invoke('\(path)')} }
            """
        }

        let args = (0 ..< argsCount).map { "a\($0)" }.joined(separator: ",")
        return """
        if(globalThis.\(path)==null) { globalThis.\(path) = function(\(args)) { window.__bridge__.invoke('\(path)', \(args))} }
        """
    }

    private func scriptForPlugin(withPath path: String, argsCount: Int) -> String {
        let array = path.components(separatedBy: ".")
        let count = array.count - 1
        var pathTmp = "globalThis"
        var code = ""
        var index = 0
        while index < count {
            pathTmp += ".\(array[index])"
            code += objectDefineJavascriptCode(path: pathTmp)
            index += 1
        }
        return code + functionDefineCode(path: path, argsCount: argsCount)
    }
}

// MARK: - Invoke JS Callback Function
extension Injector {
    private func processCallback<P: Decodable>(_ arg: P) -> P {
        guard let callbck = arg as? Callback else {
            return arg
        }
        callbck.webView = webView
        return arg
    }
}
