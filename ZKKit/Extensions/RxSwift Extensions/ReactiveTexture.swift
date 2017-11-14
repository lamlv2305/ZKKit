//
//  ReactiveTexture.swift
//  luxstay
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import RxSwift
import RxCocoa
import AsyncDisplayKit

public extension Reactive where Base: ASControlNode {
    public func controlEvent(_ event: ASControlNodeEvent) -> ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in
            MainScheduler.ensureExecutingOnScheduler()

            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }

            let controlTarget = RxTextureControlTarget(control: control, controlEvent: event, callback: { _ in
                observer.on(.next(()))
            })

            return Disposables.create(with: controlTarget.dispose)

        }.takeUntil(deallocated)

        return ControlEvent(events: source)
    }
}
