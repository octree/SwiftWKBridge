//
//  CSSInjector.swift
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

public final class CSSInjector {
    private static var scriptKey = "me.octree.cssInjector"
    
    private var cssMap = [String: String]()
    private weak var webView: WKWebView?
    
    internal init(webView: WKWebView?) {
        self.webView = webView
        injectCSSPlugin()
    }
    public func inject(css: String, forKey key: String) {
        let id = generateCSSIdentifier(key)
        cssMap[id] = css
        webView?.evaluateJavaScript(injectScript(cssMap: [id: css]), completionHandler: nil)
        reinjectScript()
    }
    
    public func removeCSS(forKey key: String) {
        let id = generateCSSIdentifier(key)
        let js = "window.__bridge__.CSSInjector.remove('\(id)');"
        cssMap.removeValue(forKey: id)
        webView?.evaluateJavaScript(js, completionHandler: nil)
        reinjectScript()
    }
    
    private func injectScript(cssMap: [String: String]) -> String {
        let data = try! JSONSerialization.data(withJSONObject: cssMap, options: [])
        let json = String(data: data, encoding: .utf8)!
        return "window.__bridge__.CSSInjector.inject(\(json));"
    }
    
    private func reinjectScript() {
        let source = "window.addEventListener('DOMContentLoaded', function() {\(injectScript(cssMap: cssMap))});"
        let script = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        webView?.injector.userScriptManager.inject(script: script, forKey: Self.scriptKey)
    }
    
    private func injectCSSPlugin() {
        reinjectScript()
    }
    
    private func generateCSSIdentifier(_ id: String) -> String {
        return "_me_octree_css_\(id)"
    }
}
