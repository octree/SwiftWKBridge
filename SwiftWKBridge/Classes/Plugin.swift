//
//  Plugin.swift
//  LydiaBox
//
//  Created by Octree on 2019/6/16.
//  Copyright © 2019 Octree. All rights reserved.
//

import WebKit

extension Data {
    func string(with encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
}

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

