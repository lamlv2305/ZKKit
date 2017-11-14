//
//  Ext+UIView.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import UIKit

private var zkExtraDataPointer: Void?
public extension UIView {
    var zkExtraData: Any? {
        get {
            return objc_getAssociatedObject(self, &zkExtraDataPointer) as Any?
        }

        set {
            objc_setAssociatedObject(self, &zkExtraDataPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func addTo(view: UIView) -> UIView {
        view.addSubview(self)
        return self
    }

    func addToView(_ view: UIView) {
        view.addSubview(self)
    }
}
