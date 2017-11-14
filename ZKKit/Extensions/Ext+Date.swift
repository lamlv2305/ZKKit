//
//  Ext+Date.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/6/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import Foundation

public extension Date {
    func compareWith(date: Date) -> Bool {
        let component = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let nextComponent = Calendar.current.dateComponents([.day, .month, .year], from: date)

        return component.day == nextComponent.day &&
            component.month == nextComponent.month &&
            component.year == nextComponent.year
    }
}
