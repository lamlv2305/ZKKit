//
//  Ext+KeyboardAvoidable.swift
//  ZKKit
//
//  Created by Luong Van Lam on 10/30/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import UIKit

public protocol KeyboardAvoidable {
    var keyboardAnimatedConstraint: [NSLayoutConstraint] { get }
    func addKeyboardObservers()
    func removeKeyboardObservers()
}

public extension KeyboardAvoidable where Self: UIViewController {
    typealias KeyboardAnimatedInfomation = (height: CGFloat, duration: Double)

    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    func addKeyboardObservers() {
        _ = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.UIKeyboardWillShow,
            object: nil,
            queue: nil,
            using: { [weak self] notification in
                self?.keyboardWillShow(notification: notification)
            }
        )

        _ = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.UIKeyboardWillHide,
            object: nil,
            queue: nil,
            using: { [weak self] notification in
                self?.keyboardWillHide(notification: notification)
            }
        )
    }

    func keyboardWillShow(notification: Notification) {
        guard let keyboardInfo = getKeyboardInfo(notification: notification) else { return }

        keyboardAnimatedConstraint.forEach { $0.constant = keyboardInfo.height }

        UIView.animated(withDuration: keyboardInfo.duration, animation: self.view.layoutIfNeeded())
    }

    func keyboardWillHide(notification: Notification) {
        guard let keyboardInfo = getKeyboardInfo(notification: notification) else { return }

        keyboardAnimatedConstraint.forEach { $0.constant = 0 }

        UIView.animated(withDuration: keyboardInfo.duration, animation: self.view.layoutIfNeeded())
    }

    func getKeyboardInfo(notification: Notification) -> KeyboardAnimatedInfomation? {
        guard let userInfo = notification.userInfo,
            let kbValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else {
                return nil
        }

        return (kbValue.cgRectValue.height, duration.doubleValue)
    }
}

fileprivate extension UIView {
    static func animated(withDuration: TimeInterval, animation: @escaping @autoclosure () -> Void) {
        UIView.animate(withDuration: withDuration, animations: animation)
    }
}
