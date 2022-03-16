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

import UIKit
import WebKit
import SwiftWKBridge

struct User: Codable {
    var name: String
    var age: Int
    var nickname: String?
}

class ViewController: UIViewController {
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let plg: (String) -> Void = {
            print("🌏 [WebView]:", $0)
        }
        webView.injector.inject(path: "wow.log",
                                plugin: plg)

        let plg2: (String, Callback) -> Void = { [weak self] in
            self?.confirm(msg: $0, callback: $1)
        }

        webView.injector["wow.confirm"] = plg2

        let plg3: (User, Callback) -> Void = { user, callback in
            var user = user
            user.nickname = "Octree"
            callback(user)
        }

        webView.injector["wow.test"] = plg3

        webView.loadHTMLString(String(fileName: "test", type: "html")!,
                               baseURL: nil)

        let plg4: (String) -> Void = {
            print("🌏 [WebView]:", $0)
        }
        webView.injector.inject(path: "println",
                                plugin: plg4)
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
