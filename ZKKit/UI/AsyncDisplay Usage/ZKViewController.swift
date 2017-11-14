//
//  ZKViewController.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/14/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import AsyncDisplayKit
import RxSwift

open class ZKViewController: ASViewController<ZKDisplayNode> {
    /**
     *  Rx Variables
     */
    fileprivate let bag = DisposeBag()

    /**
     *  Internal Flags or something like this
     */
    typealias PrepareLoadMainLayout = (() -> Void) -> Void
    var preloadMainLayout: PrepareLoadMainLayout?

    /**
     *  Data
     */

    // MARK: End declaration
    public init() {
        super.init(node: ZKDisplayNode())

        [loadingNode, emptyNode, errorNode, mainNode].forEach {
            $0.style.preferredSize = UIScreen.main.bounds.size
            $0.style.flexShrink = 1.0
            $0.style.flexGrow = 1.0
        }

        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = nodeLayout(node: size:)
        node.layoutTransitionBlock = layoutTransition(context:)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        title = ""

        handleRx()
    }
}

// MARK: - ZKNodeControllerProtocol
extension ZKViewController: ZKNodeControllerProtocol {
    open var disposeBag: DisposeBag {
        return bag
    }

    public var mainNode: ASDisplayNode {
        fatalError("ZKViewController: You have to specific mainNode:ASDisplayNode here")
    }

    public var loadingNode: ASDisplayNode {
        fatalError("ZKViewController: You have to specific loadingNode:ASDisplayNode here")
    }

    public var emptyNode: ASDisplayNode {
        fatalError("ZKViewController: You have to specific emptyNode:ASDisplayNode here")
    }

    public var errorNode: ASDisplayNode {
        fatalError("ZKViewController: You have to specific emptyNode:ASDisplayNode here")
    }

    public var viewModel: ZKNodeModelProtocol {
        fatalError("ZKViewController: You have to specific viewModel:ZKNodeModelProtocol here")
    }

    public func layoutTransition(context: ASContextTransitioning) {
        // swiftlint:disable empty_enum_arguments
        let dataArray: [[ASDisplayNode]] = [
            [loadingNode],
            [mainNode],
            [emptyNode],
            [errorNode]
        ]

        var index = -1
        switch viewModel.viewState.value {
        case .onLoading:
            index = 0
        case .onComplete:
            index = 1
        case .onEmpty:
            index = 2
        case .onError(_):
            index = 3
        }

        let animationBlock = {
            guard index >= 0 else { return }
            dataArray.enumerated().forEach { data in
                let alpha: CGFloat = data.offset == index ? 1 : 0
                data.element.forEach { $0.alpha = alpha }
            }
        }

        let completionBlock: (Bool) -> Void = { [weak self] complete in
            guard self != nil, index >= 0, complete else { return }
            dataArray.enumerated().forEach { data in
                data.element
                    .filter { $0.alpha == 0 }
                    .forEach { $0.removeFromSupernode() }
            }
        }

        UIView.animate(withDuration: 0.4, animations: animationBlock, completion: completionBlock)
        // swiftlint:enable empty_enum_arguments
    }

    public func nodeLayout(node: ASDisplayNode, size: ASSizeRange) -> ASLayoutSpec {
        switch viewModel.viewState.value {
        case .onLoading:
            return ASInsetLayoutSpec(insets: .zero, child: loadingNode)

        case .onEmpty:
            return ASInsetLayoutSpec(insets: .zero, child: emptyNode)

        case .onError(_):
            return ASInsetLayoutSpec(insets: .zero, child: errorNode)

        default:
            return ASInsetLayoutSpec(
                insets: .zero,
                child: mainNode
            )
        }
    }

    public func handleRx() {
        viewModel.viewState.asDriver()
            .distinctUntilChanged()
            .drive(onNext: { [weak self] state in
                guard let this = self else { return }
                guard state == ViewState.onComplete, let prepare = this.preloadMainLayout else {
                    return this.node.transitionLayout(
                        withAnimation: true,
                        shouldMeasureAsync: true,
                        measurementCompletion: nil
                    )
                }

                prepare { [weak self] in
                    self?.node.transitionLayout(
                        withAnimation: true,
                        shouldMeasureAsync: true,
                        measurementCompletion: nil
                    )
                }
            })
            .disposed(by: disposeBag)
    }
}

