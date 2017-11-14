//
//  StringExtension.swift
//  ZKKit
//
//  Created by Luong Van Lam on 10/24/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import Foundation

public extension String {
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
}
