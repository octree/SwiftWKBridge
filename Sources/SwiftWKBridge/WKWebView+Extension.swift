//
//  WKWebView+Injector.swift
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

private var kSwiftyWebViewInjectorKey = "kSwiftWKInjector"

public extension WKWebView {

    /// Injector to manage plugins for a WKWebView
    var injector: Injector {
        get {
            if let injector = objc_getAssociatedObject(self, &kSwiftyWebViewInjectorKey) as? Injector {
                return injector
            } else {

                let injector = Injector(webView: self)
                objc_setAssociatedObject(self, &kSwiftyWebViewInjectorKey, injector, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return injector
            }
        }
        set {
            objc_setAssociatedObject(self, &kSwiftyWebViewInjectorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private let kOCTNightCSSID = "me.octree.nightcss"

enum NightScript {
    static var key = "me.octree.night.script"
    static var script = WKUserScript(source: "window.__bridge__.NightMode.setEnabled(true)", injectionTime: .atDocumentStart, forMainFrameOnly: true)
}

public extension WKWebView {

    func nightFall() {
        evaluateJavaScript("""
        window.__bridge__.NightMode.setEnabled(true);
        """, completionHandler: nil)
        injector.userScriptManager.inject(script: NightScript.script, forKey: NightScript.key)
    }

    func sunrise() {
        evaluateJavaScript("""
        window.__bridge__.NightMode.setEnabled(false);
        """, completionHandler: nil)
        injector.userScriptManager.remove(forKey: NightScript.key)
    }
}
