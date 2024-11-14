import Foundation
import WebKit

struct PromiseResult<V: Encodable>: Encodable {
    public var value: V?
    public var error: String?

    public init(value: V) {
        self.value = value
    }

    public init(error: String) {
        self.error = error
    }
}

public extension Injector {
    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<R: Encodable>(path: String, plugin: @escaping () async throws -> R, injectionTime: WKUserScriptInjectionTime = .atDocumentStart) {
        let f: (Args1<Callback>) -> Void = { args in
            Task {
                let callback = self.processCallback(args.arg0)
                do {
                    try await callback.invoke(PromiseResult(value: plugin()))
                } catch {
                    callback.invoke(PromiseResult<R>(error: error.localizedDescription))
                }
            }
        }
        _injectPromise(path: path, plugin: f, argsCount: 0)
    }

    func inject<P0: Decodable, R: Encodable>(path: String, plugin: @escaping (P0) async throws -> R, injectionTime: WKUserScriptInjectionTime = .atDocumentStart) {
        let f: (Args2<P0, Callback>) -> Void = { args in
            Task {
                let callback = self.processCallback(args.arg1)
                do {
                    try await callback.invoke(PromiseResult(value: plugin(
                        self.processCallback(args.arg0)
                    )))
                } catch {
                    callback.invoke(PromiseResult<R>(error: error.localizedDescription))
                }
            }
        }
        _injectPromise(path: path, plugin: f, argsCount: 1)
    }

    func inject<P0, P1, R>(path: String,
                           plugin: @escaping (P0, P1) async throws -> R,
                           injectionTime: WKUserScriptInjectionTime = .atDocumentStart)
        where P0: Decodable, P1: Decodable, R: Encodable {
        let f: (Args3<P0, P1, Callback>) -> Void = { args in
            Task {
                let callback = self.processCallback(args.arg2)
                do {
                    try await callback.invoke(PromiseResult(value: plugin(
                        self.processCallback(args.arg0),
                        self.processCallback(args.arg1)
                    )))
                } catch {
                    callback.invoke(PromiseResult<R>(error: error.localizedDescription))
                }
            }
        }
        _injectPromise(path: path, plugin: f, argsCount: 2)
    }

    func inject<P0, P1, P2, R>(path: String,
                               plugin: @escaping (P0, P1, P2) async throws -> R,
                               injectionTime: WKUserScriptInjectionTime = .atDocumentStart)
        where P0: Decodable, P1: Decodable, P2: Decodable, R: Encodable {
        let f: (Args4<P0, P1, P2, Callback>) -> Void = { args in
            Task {
                let callback = self.processCallback(args.arg3)
                do {
                    try await callback.invoke(PromiseResult(value: plugin(
                        self.processCallback(args.arg0),
                        self.processCallback(args.arg1),
                        self.processCallback(args.arg2)
                    )))
                } catch {
                    callback.invoke(PromiseResult<R>(error: error.localizedDescription))
                }
            }
        }
        _injectPromise(path: path, plugin: f, argsCount: 3)
    }

    private func _injectPromise<Arg: ArgsType>(path: String, plugin: @escaping (Arg) -> Void, injectionTime: WKUserScriptInjectionTime = .atDocumentStart, argsCount: Int) {
        pluginMap[path] = Plugin(webView: webView, path: path, f: plugin)
        inject(script: scriptForPlugin(withPath: path, argsCount: argsCount, isPromise: true),
               key: path,
               injectionTime: injectionTime,
               forMainFrameOnly: false)
    }
}
