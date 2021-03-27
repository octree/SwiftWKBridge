//
//  WKWebView+Injector.swift
//  LydiaBox
//
//  Created by Octree on 2019/6/16.
//  Copyright © 2019 Octree. All rights reserved.
//

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
