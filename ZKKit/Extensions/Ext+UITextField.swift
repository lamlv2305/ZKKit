//
//  Ext+UITextField.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import UIKit

public extension UITextField {
    enum SpacePosition {
        case left
        case right
    }

    func addSpace(on position: SpacePosition, width: CGFloat, mode: UITextFieldViewMode) {
        if position == SpacePosition.left {
            self.addSpaceLeft(width: width, mode: mode)
        } else {
            self.addSpaceRight(width: width, mode: mode)
        }
    }

    fileprivate func addSpaceLeft(width: CGFloat, mode: UITextFieldViewMode) {
        guard self.leftView == nil else { return }

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
        leftView.backgroundColor = UIColor.clear
        self.leftView = leftView
        self.leftViewMode = mode
    }

    fileprivate func addSpaceRight(width: CGFloat, mode: UITextFieldViewMode) {
        guard self.rightView == nil else { return }

        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
        self.rightView = rightView
        self.rightViewMode = mode
    }
}
