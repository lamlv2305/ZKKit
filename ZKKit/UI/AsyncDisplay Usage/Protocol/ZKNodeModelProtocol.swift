//
//  ZKNodeModelProtocol.swift
//  ZKKit
//
//  Created by Luong Van Lam on 11/14/17.
//  Copyright © 2017 lamlv. All rights reserved.
//

import Foundation
import RxSwift

public enum ViewState: Equatable {
    case onLoading
    case onComplete
    case onEmpty
    case onError(msg: String)

    public static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.onLoading, .onLoading): return true
        case (.onComplete, .onComplete): return true
        case (.onEmpty, .onEmpty): return true
        case (.onError(let msg), .onError(let _msg)):
            return msg == _msg
        default:
            return false
        }
    }
}
// Test Git-Flow Comment
// Test Git Flow
// Ahihi
public protocol ZKNodeModelProtocol {
    associatedtype DataType

    var disposeBag: DisposeBag { get }
    var hasNextPage: Variable<Bool> { get }
    var viewState: Variable<ViewState> { get }
    var data: DataType { get }
}
