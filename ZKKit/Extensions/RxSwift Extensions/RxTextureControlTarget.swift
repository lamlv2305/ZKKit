//
//  RxTextureControlTarget.swift
//  luxstay
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import RxSwift
import RxCocoa
import AsyncDisplayKit

public class RxTextureControlTarget: NSObject, Disposable {
    private var retainSelf: RxTextureControlTarget?

    typealias Callback = (ASControlNode) -> Void

    var control: ASControlNode?
    var callback: Callback?
    let controlEvent: ASControlNodeEvent

    let selector: Selector = #selector(RxTextureControlTarget.eventHandler(_:))

    init(control: ASControlNode, controlEvent: ASControlNodeEvent, callback: @escaping Callback) {
        MainScheduler.ensureExecutingOnScheduler()

        self.control = control
        self.controlEvent = controlEvent
        self.callback = callback

        super.init()

        self.retainSelf = self

        control.addTarget(self, action: selector, forControlEvents: controlEvent)

        guard self.method(for: self.selector) != nil else {
            fatalError("Can't find method")
        }
    }

    public func dispose() {
        self.control?.removeTarget(self, action: self.selector, forControlEvents: self.controlEvent)
        self.callback = nil

        self.retainSelf = nil
    }

    @objc func eventHandler(_ sender: ASControlNode!) {
        if let callback = self.callback, let control = self.control {
            callback(control)
        }
    }
}
