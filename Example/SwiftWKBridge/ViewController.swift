//
//  ViewController.swift
//  SwiftWKBridge
//
//  Created by Octree on 08/16/2019.
//  Copyright (c) 2019 Octree. All rights reserved.
//

import UIKit
import WebKit
import SwiftWKBridge

struct User: Codable {
    var name: String
    var age: Int
    var nickname: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plg: (String) -> Void = {
            print("🌏 [WebView]:", $0)
        }
        webView.injector.inject(path: "window.bridge.log",
                                plugin: plg)

        let plg2: (String, Callback) -> Void = { [weak self] in
            self?.confirm(msg: $0, callback: $1)
        }

        webView.injector["window.bridge.confirm"] = plg2

        let plg3: (User, Callback) -> Void = { user, callback in
            var user = user
            user.nickname = "Octree"
            callback.invoke(user)
        }

        webView.injector["window.bridge.test"] = plg3

        webView.loadHTMLString(String(fileName: "test", type: "html")!,
                               baseURL: nil)
    }

    func confirm(msg: String, callback: Callback) {
        let alertVC = UIAlertController(title: "Confirm",
                                        message: msg,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok",
                                        style: .default,
                                        handler: { _ in
                                            callback.invoke("Ok, " + msg)
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

