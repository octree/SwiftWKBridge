//
//  String+Resource.swift
//  LydiaBox
//
//  Created by Octree on 2019/6/16.
//  Copyright © 2019 Octree. All rights reserved.
//

import Foundation

public extension String {
    init?(fileName:String, type: String, bundle: Bundle = Bundle.main) {
        guard let path = bundle.path(forResource: fileName, ofType: type) else {
            return nil
        }
        do {
            try self.init(contentsOfFile: path)
        } catch {
            return nil
        }
    }
}
