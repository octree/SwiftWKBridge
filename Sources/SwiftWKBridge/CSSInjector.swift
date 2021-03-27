//
//  CSSInjector.swift
//  LydiaBox
//
//  Created by Octree on 2019/7/13.
//  Copyright © 2019 Octree. All rights reserved.
//

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
