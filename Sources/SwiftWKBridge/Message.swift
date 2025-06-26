//
//  Message.swift
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

import Foundation
import WebKit

private extension Encodable {
    func toJSONData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

public final class Callback: Decodable, @unchecked Sendable {
    private enum CodingKeys: String, CodingKey {
        case id
    }

    let id: String
    weak var webView: WKWebView?

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        webView = decoder.userInfo[.webView] as? WKWebView
    }

    public func invoke(_ args: Encodable...) {
        _invoke(args: args)
    }

    public func callAsFunction(_ args: Encodable...) {
        _invoke(args: args)
    }

    private func _invoke(args: [Encodable]) {
        guard let webView else { return }
        do {
            let params = try args.map { try String(data: $0.toJSONData(), encoding: .utf8)! }.joined(separator: ", ")
            var source: String
            if !params.isEmpty {
                source = "window.__bridge__.CBDispatcher.invoke('\(id)', \(params))"
            } else {
                source = "window.__bridge__.CBDispatcher.invoke('\(id)')"
            }

            if Thread.current.isMainThread {
                webView.evaluateJavaScript(source, completionHandler: nil)
            } else {
                DispatchQueue.main.async {
                    webView.evaluateJavaScript(source, completionHandler: nil)
                }
            }
        } catch {
            fatalError()
        }
    }

    public func invoke(script args: String) {
        guard let webView else { return }
        let source = "window.__bridge__.CBDispatcher.invoke('\(id)', \(args))"
        if Thread.current.isMainThread {
            webView.evaluateJavaScript(source, completionHandler: nil)
        } else {
            DispatchQueue.main.async {
                webView.evaluateJavaScript(source, completionHandler: nil)
            }
        }
    }

    deinit {
        let source = "window.__bridge__.CBDispatcher.remove('\(id)')"
        guard let webView else { return }
        if Thread.current.isMainThread {
            webView.evaluateJavaScript(source, completionHandler: nil)
        } else {
            DispatchQueue.main.async {
                webView.evaluateJavaScript(source, completionHandler: nil)
            }
        }
    }
}

protocol ArgsType: Decodable {}

struct Args0: Decodable, ArgsType {}

struct Args1<P0: Decodable>: Decodable, ArgsType {
    var arg0: P0
}

struct Args2<P0: Decodable, P1: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
}

struct Args3<P0: Decodable, P1: Decodable, P2: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
}

struct Args4<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
}

struct Args5<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
}

struct Args6<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
    var arg5: P5
}

struct Args7<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
    var arg5: P5
    var arg6: P6
}

struct Args8<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable, P7: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
    var arg5: P5
    var arg6: P6
    var arg7: P7
}

protocol _OptionalProtocol: ExpressibleByNilLiteral {}
extension Optional: _OptionalProtocol {}

private enum CodingKeys: String, CodingKey {
    case arg0
    case arg1
    case arg2
    case arg3
    case arg4
    case arg5
    case arg6
    case arg7
}

private extension KeyedDecodingContainer {
    func maybeOptionalDecode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        if let optional = T.self as? _OptionalProtocol.Type {
            return try decodeIfPresent(T.self, forKey: key) ?? (optional.init(nilLiteral: ()) as! T)
        } else {
            return try decode(T.self, forKey: key)
        }
    }
}

extension Args1 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
    }
}

extension Args2 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
        arg1 = try container.maybeOptionalDecode(P1.self, forKey: .arg1)
    }
}

extension Args3 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
        arg1 = try container.maybeOptionalDecode(P1.self, forKey: .arg1)
        arg2 = try container.maybeOptionalDecode(P2.self, forKey: .arg2)
    }
}

extension Args4 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
        arg1 = try container.maybeOptionalDecode(P1.self, forKey: .arg1)
        arg2 = try container.maybeOptionalDecode(P2.self, forKey: .arg2)
        arg3 = try container.maybeOptionalDecode(P3.self, forKey: .arg3)
    }
}

extension Args5 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
        arg1 = try container.maybeOptionalDecode(P1.self, forKey: .arg1)
        arg2 = try container.maybeOptionalDecode(P2.self, forKey: .arg2)
        arg3 = try container.maybeOptionalDecode(P3.self, forKey: .arg3)
        arg4 = try container.maybeOptionalDecode(P4.self, forKey: .arg4)
    }
}

extension Args6 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
        arg1 = try container.maybeOptionalDecode(P1.self, forKey: .arg1)
        arg2 = try container.maybeOptionalDecode(P2.self, forKey: .arg2)
        arg3 = try container.maybeOptionalDecode(P3.self, forKey: .arg3)
        arg4 = try container.maybeOptionalDecode(P4.self, forKey: .arg4)
        arg5 = try container.maybeOptionalDecode(P5.self, forKey: .arg5)
    }
}

extension Args7 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
        arg1 = try container.maybeOptionalDecode(P1.self, forKey: .arg1)
        arg2 = try container.maybeOptionalDecode(P2.self, forKey: .arg2)
        arg3 = try container.maybeOptionalDecode(P3.self, forKey: .arg3)
        arg4 = try container.maybeOptionalDecode(P4.self, forKey: .arg4)
        arg5 = try container.maybeOptionalDecode(P5.self, forKey: .arg5)
        arg6 = try container.maybeOptionalDecode(P6.self, forKey: .arg6)
    }
}

extension Args8 {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arg0 = try container.maybeOptionalDecode(P0.self, forKey: .arg0)
        arg1 = try container.maybeOptionalDecode(P1.self, forKey: .arg1)
        arg2 = try container.maybeOptionalDecode(P2.self, forKey: .arg2)
        arg3 = try container.maybeOptionalDecode(P3.self, forKey: .arg3)
        arg4 = try container.maybeOptionalDecode(P4.self, forKey: .arg4)
        arg5 = try container.maybeOptionalDecode(P5.self, forKey: .arg5)
        arg6 = try container.maybeOptionalDecode(P6.self, forKey: .arg6)
        arg7 = try container.maybeOptionalDecode(P7.self, forKey: .arg7)
    }
}
