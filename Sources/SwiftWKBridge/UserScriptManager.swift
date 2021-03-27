//
//  UserScriptManager.swift
//  LydiaBox
//
//  Created by Octree on 2019/7/12.
//  Copyright © 2019 Octree. All rights reserved.
//

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
                            forMainFrameOnly: true)
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
