//
//  UIState.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/6.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import UIKit

// MARK: - UIState
///A list of states. Binding data content to specific view
enum UIState<DataModel: Codable> {
    case loading
    case loaded(DataModel) //載入完成
    case error(NetworkingError)
    case empty(String)
}

// MARK: - UIStateProtocol
///For UIState implementation
protocol UIStateProtocol {
    associatedtype DataModel: Codable
    
    var state: UIState<DataModel> { get set }
    var loadingView: LoadingView { get }
    var errorView: ErrorView { get }
    var emptyView: EmptyView { get }
    
    func update()
}

extension UIStateProtocol where Self: UIViewController {
    func update() {
        switch state {
        case .loading:
            loadingView.isHidden = false
            errorView.isHidden = true
            emptyView.isHidden = true
        case .error(let errorMessage):
            loadingView.isHidden = true
            errorView.isHidden = false
            emptyView.isHidden = true
        case .empty(let emptyMessage):
            loadingView.isHidden = true
            errorView.isHidden = true
            emptyView.isHidden = false
        case .loaded:
            loadingView.isHidden = true
            errorView.isHidden = true
            emptyView.isHidden = true
        }
    }
}
