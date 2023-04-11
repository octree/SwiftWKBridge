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

public class Callback: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
    }

    var id: String
    weak var webView: WKWebView?

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
