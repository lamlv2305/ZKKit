//
//  ZKNavigationBar.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/14/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import UIKit

open class ZKNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        barTintColor = UIColor.white
        isTranslucent = false
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        guard #available(iOS 11, *) else { return }

        self.layoutMargins = .zero
        subviews.forEach { (sub) in
            if NSStringFromClass(sub.classForCoder).contains("ContentView") {
                sub.layoutMargins = .zero
            }
        }
    }
}
