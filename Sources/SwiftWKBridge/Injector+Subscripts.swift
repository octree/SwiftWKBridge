//
//  Injector+Subscripts.swift
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

import Foundation

public extension Injector {

    subscript(path: String) -> (() -> Void)? {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0>(path: String) -> ((P0) -> Void)?
        where P0: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0, P1>(path: String) -> ((P0, P1) -> Void)?
        where P0: Decodable, P1: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0, P1, P2>(path: String) -> ((P0, P1, P2) -> Void)?
        where P0: Decodable, P1: Decodable, P2: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0, P1, P2, P3>(path: String) -> ((P0, P1, P2, P3) -> Void)?
        where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0, P1, P2, P3, P4>(path: String) -> ((P0, P1, P2, P3, P4) -> Void)?
        where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0, P1, P2, P3, P4, P5>(path: String) -> ((P0, P1, P2, P3, P4, P5) -> Void)?
        where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0, P1, P2, P3, P4, P5, P6>(path: String) -> ((P0, P1, P2, P3, P4, P5, P6) -> Void)?
        where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }

    subscript<P0, P1, P2, P3, P4, P5, P6, P7>(path: String) -> ((P0, P1, P2, P3, P4, P5, P6, P7) -> Void)?
        where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable, P7: Decodable {
        set {
            if let f = newValue {
                inject(path: path, plugin: f)
            } else {
                removePlugin(forPath: path)
            }
        }

        get {
            return nil
        }
    }
}
