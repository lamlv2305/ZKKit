//
//  Ext+ASLayoutSpec.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import AsyncDisplayKit

public extension ASLayoutSpec {
    func flexLayout() -> ASLayoutSpec {
        self.style.flexGrow = 1.0
        self.style.flexShrink = 1.0
        return self
    }
}
