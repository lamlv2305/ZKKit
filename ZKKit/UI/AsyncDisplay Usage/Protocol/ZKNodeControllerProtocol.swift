//
//  ZKNodeControllerProtocol.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/14/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import AsyncDisplayKit
import RxSwift

public protocol ZKNodeControllerProtocol {
    var disposeBag: DisposeBag { get }
    var mainNode: ASDisplayNode { get }
    var loadingNode: ASDisplayNode { get }
    var emptyNode: ASDisplayNode { get }
    var errorNode: ASDisplayNode { get }

    var viewModel: ZKNodeModelProtocol { get }

    func layoutTransition(context: ASContextTransitioning)
    func nodeLayout(node: ASDisplayNode, size: ASSizeRange) -> ASLayoutSpec
    func handleRx()
}

