//
//  ZKDisplayNode.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/14/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import AsyncDisplayKit

open class ZKDisplayNode: ASDisplayNode {
    typealias LayoutTransitionBlock = (ASContextTransitioning) -> Void
    var layoutTransitionBlock: LayoutTransitionBlock?

    override public init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    override open func animateLayoutTransition(_ context: ASContextTransitioning) {
        guard let transition = layoutTransitionBlock else {
            return super.animateLayoutTransition(context)
        }

        transition(context)
    }
}
