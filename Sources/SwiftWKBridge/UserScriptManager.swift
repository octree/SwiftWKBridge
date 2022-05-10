//
//  UserScriptManager.swift
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

/// User Script Manager
public final class UserScriptManager {
    weak var webView: WKWebView?

    /// Javascript code to dispatch invocation between javascript and swift
    private static let coreScript: WKUserScript = {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: UserScriptManager.self)
        #endif
        let source = String(fileName: "core", type: "js", bundle: bundle)!
        return WKUserScript(source: source,
                            injectionTime: .atDocumentStart,
                            forMainFrameOnly: false)
    }()

    /// key: Identifier for script
    private var scriptMap = [String: WKUserScript]()

    init(webView: WKWebView?) {
        self.webView = webView
        reinject()
    }

    /// Inject an js script in webView
    /// - Parameter script: An instance of WKUserScript
    /// - Parameter key: Unique key
    public func inject(script: WKUserScript, forKey key: String) {
        if scriptMap[key] == nil {
            scriptMap[key] = script
            webView?.configuration.userContentController.addUserScript(script)
        } else {
            scriptMap[key] = script
            reinject()
        }
    }

    /// Remove an user script from webView
    /// - Parameter key: Unique key
    public func remove(forKey key: String) {
        guard scriptMap[key] != nil else {
            return
        }
        scriptMap[key] = nil
        reinject()
    }

    private func reinject() {
        guard let userController = webView?.configuration.userContentController else {
            return
        }
        userController.removeAllUserScripts()
        userController.addUserScript(Self.coreScript)
        scriptMap.forEach {
            userController.addUserScript($0.value)
        }
    }
}
