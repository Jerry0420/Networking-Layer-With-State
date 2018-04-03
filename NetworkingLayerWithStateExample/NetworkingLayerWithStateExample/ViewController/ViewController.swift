//
//  ViewController.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/3.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, UIStateProtocol {
    
    var memberApiService: MemberAPIService?
    
    var state: UIState<[Member]> = UIState.loading {
        didSet {
            switch state {
            //binding content to specific view
            case .loaded(let model):
                update()
                print("render loaded UI by model")
            default:
                update()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
    }
    
    private func loadContent() {
        //kind of like transition
        state = .loading
        memberApiService = MemberAPIService()
        memberApiService?.signUp(key1: "value1", key2: "value2", header: "headerValue", model: ResponseMemberData.self) { [weak self](result) in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let dataModel):
                weakSelf.state = (dataModel.members.count > 0) ? (.loaded(dataModel.members)) : (.empty("input empty category...."))
            case .failure(let error):
                weakSelf.state = .error(error)
            }
            }.resume()
    }
}
