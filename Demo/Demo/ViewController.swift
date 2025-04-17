//
//  ViewController.swift
//  SwiftWKBridge
//
//  Created by Octree on 2019/7/12.
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

import SwiftWKBridge
import UIKit
import WebKit

struct User: Codable {
    var name: String
    var age: Int
    var nickname: String?
}

struct CodableError: Encodable, Error {
    let code: Int
    let message: String
}

class ViewController: UIViewController {
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }

        let plg: (String) -> Void = {
            print("🌏 [WebView]:", $0)
        }
        webView.injector.inject(path: "wow.log",
                                plugin: plg)

        let plg2: (String, Callback) -> Void = { [weak self] in
            self?.confirm(msg: $0, callback: $1)
        }

        webView.injector["wow.confirm"] = plg2

        let plg3: (User, User?, Callback) -> Void = { user, optionalUser, callback in
            var user = user
            user.nickname = "Octree"
            callback(user)
        }

        webView.injector["wow.test", at: .atDocumentEnd] = plg3

        webView.loadHTMLString(String(fileName: "test", type: "html")!,
                               baseURL: nil)

        let plg4: (String) -> Void = {
            print("🌏 [WebView]:", $0)
        }
        webView.injector.inject(path: "println",
                                plugin: plg4)

        let async0: () async throws -> String = { [weak webView] in
            let new: () async throws -> String = {
                "world"
            }
            webView?.injector.inject(path: "async3", plugin: new)
            return "hello"
        }

        let async1: (String) async throws -> String = {
            "hello \($0)"
        }

        let async2: (String, String) async throws -> String = {
            "hello \($0) \($1)"
        }

        let asyncThrow: () async throws -> String = {
            throw NSError(domain: "1234", code: -13, userInfo: [NSLocalizedDescriptionKey: "reason"])
        }

        let encodableThrow: () async throws -> String = {
            throw CodableError(code: 123, message: "error")
        }

        let promiseJson = "{\"name\": \"Octree\", \"age\": 18}"
        let jsonPlugin: () async throws -> String = { promiseJson }
        webView.injector.inject(path: "scriptPlugin", script: jsonPlugin)

        let jsonPlugin1: (Int) async throws -> String = { "{\"name\": \"Octree\", \"age\": \($0)}" }
        webView.injector.inject(path: "scriptPlugin1", script: jsonPlugin1)

        let jsonPlugin2: (Int, String) async throws -> String = { "{\"name\": \"\($1)\", \"age\": \($0)}" }
        webView.injector.inject(path: "scriptPlugin2", script: jsonPlugin2)

        let jsonPlugin3: (Int, String, String) async throws -> String = { "{\"name\": \"\($1)\", \"age\": \($0), \"nickname\": \"\($2)\"}" }
        webView.injector.inject(path: "scriptPlugin3", script: jsonPlugin3)

        webView.injector.inject(path: "async0", plugin: async0)
        webView.injector.inject(path: "async1", plugin: async1)
        webView.injector.inject(path: "async2", plugin: async2)
        webView.injector.inject(path: "asyncThrow", plugin: asyncThrow)
        webView.injector.inject(path: "encodableThrow", plugin: encodableThrow)

        let asyncVoid: () async throws -> Void = {
            print("hello void")
        }

        let asyncVoid1: (String) async throws -> Void = {
            print("hello void\($0)")
        }

        let asyncVoid2: (String, String) async throws -> Void = {
            print("hello void \($0) \($1)")
            throw NSError(domain: "123", code: 1_234_123)
        }

        webView.injector.inject(path: "asyncVoid0", plugin: asyncVoid)
        webView.injector.inject(path: "asyncVoid1", plugin: asyncVoid1)
        webView.injector.inject(path: "asyncVoid2", plugin: asyncVoid2)
    }

    func confirm(msg: String, callback: Callback) {
        let alertVC = UIAlertController(title: "Confirm",
                                        message: msg,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok",
                                        style: .default,
                                        handler: { _ in
                                            callback("Ok, " + msg)
                                        }))
        present(alertVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func injectCSS(_ sender: Any) {
        webView.injector.cssInjector.inject(css: String(fileName: "test", type: "css")!, forKey: "css")
    }

    @IBAction func removeCSS(_ sender: Any) {
        webView.injector.cssInjector.removeCSS(forKey: "css")
    }

    @IBAction func nightFall(_ sender: Any) {
        webView.nightFall()
    }

    @IBAction func sunrise(_ sender: Any) {
        webView.sunrise()
    }
}
