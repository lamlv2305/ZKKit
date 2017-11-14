//
//  Ext+NSMutableAttributedString.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/1/17.
//  Copyright © 2017 lamlv. All rights reserved.
//
import UIKit

public extension NSMutableAttributedString {
    func font(font: UIFont) -> NSMutableAttributedString {
        let range = (string as NSString).range(of: string)
        self.addAttributes([NSAttributedStringKey.font: font], range: range)
        return self
    }

    func textColor(color: UIColor) -> NSMutableAttributedString {
        let range = (string as NSString).range(of: string)
        self.addAttributes([NSAttributedStringKey.foregroundColor: color], range: range)
        return self
    }

    func paragraph(style: (() -> NSParagraphStyle)) -> NSMutableAttributedString {
        let range = (string as NSString).range(of: string)
        self.addAttributes([NSAttributedStringKey.paragraphStyle: style()], range: range)
        return self
    }

    func backgroundColor(color: UIColor) -> NSMutableAttributedString {
        let range = (string as NSString).range(of: string)
        self.addAttributes([NSAttributedStringKey.backgroundColor: color], range: range)
        return self
    }

    func strikeThrough() -> NSMutableAttributedString {
        for (index, item) in self.string.enumerated() {

            guard item.description != " " else {
                let spaceRange = NSRange(location: index, length: 1)
                let style = NSUnderlineStyle.styleNone.rawValue
                self.addAttributes([NSAttributedStringKey.strikethroughStyle: style], range: spaceRange)
                continue
            }

            let spaceRange = NSRange(location: index, length: 1)
            let style = NSUnderlineStyle.styleSingle.rawValue
            self.addAttributes([NSAttributedStringKey.strikethroughStyle: style], range: spaceRange)
        }

        return self
    }

    func clearStyleOnSpace() -> NSMutableAttributedString {
        var range = (string as NSString).range(of: string)

        let rawArray = self.string.components(separatedBy: " ")
        let attributes = self.attributes(at: 0, effectiveRange: &range)

        let mutableString = NSMutableAttributedString()

        for item in rawArray {
            var text = item
            if mutableString.string != "" {
                text = " \(text)"
            }

            let current = NSAttributedString(string: text, attributes: attributes)
            mutableString.append(current)
        }

        return mutableString
    }
}
