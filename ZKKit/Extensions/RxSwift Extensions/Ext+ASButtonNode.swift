//
//  Ext+ASButtonNode.swift
//  luxstay
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import RxSwift
import RxCocoa
import AsyncDisplayKit

public extension Reactive where Base: ASButtonNode {
    public var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
