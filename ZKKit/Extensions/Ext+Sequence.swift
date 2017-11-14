//
//  Ext+Sequence.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/4/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import Foundation

public extension Array {
    func firstOrDefault(_ defaultValue: Element) -> Element {
        return self.first ?? defaultValue
    }
}
