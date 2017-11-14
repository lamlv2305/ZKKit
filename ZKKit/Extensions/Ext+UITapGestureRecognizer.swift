//
//  UITapGestureRecognizerExtension.swift
//  ZKKit
//
//  Created by Luong Van Lam on 10/28/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import UIKit

public extension UITapGestureRecognizer {
    func addTo(view: UIView) -> UITapGestureRecognizer {
        view.addGestureRecognizer(self)
        return self
    }
}
