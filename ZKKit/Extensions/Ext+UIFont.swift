//
//  Ext+Font.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import UIKit

public extension UIFont {
    static func luxstayIcon(fontSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "luxstay-icon", size: size) else {
            fatalError("Couldn't load luxstay icon font")
        }

        return font
    }

    static func luxstayDefault(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica", size: size) else {
            fatalError("Couldn't load Helvetica font")
        }

        return font
    }

    static func luxstayBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: size) else {
            fatalError("Couldn't load Helvetica font")
        }

        return font
    }
}
