//
//  Plugin.swift
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

class AnyPlugin {
    func invoke(argString: String) {
    }
}

class Plugin<Arg: ArgsType>: AnyPlugin {
    
    private weak var webView: WKWebView?
    let f: (Arg) -> ()
    private let path: String
    
    init(webView: WKWebView?, path: String, f: @escaping (Arg) -> ()) {
        self.path = path
        self.webView = webView
        self.f = f
    }
    
    override func invoke(argString: String) {
        guard let data = argString.data(using: .utf8) else {
            fatalError()
        }
        do {
            let args = try JSONDecoder().decode(Arg.self, from: data)
            f(args)
        } catch {
            print("🍎 [Plugin] Cannot invoke plugin(\(path)) with args: \(argString), error: \(error)")
        }
    }
}

