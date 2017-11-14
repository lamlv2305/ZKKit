//
//  UIStoryboardExtension.swift
//  ZKKit
//
//  Created by Luong Van Lam on 10/24/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    func initViewController<T: UIViewController>() -> T {
        let identifier = String(describing: T.self)
        guard let obj = self.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Can't find any class name with identifier: \(identifier)")
        }
        return obj
    }
}
