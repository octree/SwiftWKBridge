//
//  Injector+Subscripts.swift
//  LydiaBox
//
//  Created by Octree on 2019/8/16.
//  Copyright © 2019 Octree. All rights reserved.
//

import Foundation

public extension Injector {

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

