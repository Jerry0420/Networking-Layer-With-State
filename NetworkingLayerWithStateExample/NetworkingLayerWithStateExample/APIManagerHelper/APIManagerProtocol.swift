//
//  BaseAPIManager.swift
//  BumpTwo
//
//  Created by JerryWang on 2018/1/28.
//  Copyright © 2018年 Jerrywang. All rights reserved.
//

import UIKit

// MARK: - URLs implementation protocol
///All URL layer need to implement this protocol
typealias RequestModel = (parameters: [String : Any]?, header: [String: String]?)

protocol APIEndPointProtocol {
    func provideValues()-> APIRequestValues
}

struct APIRequestValues {
    let url: String
    let httpVerb: URLRequest.HTTPVerb
    let requestModel: RequestModel
    let contentType: URLRequest.ContentType
    
    init (url: String, httpVerb: URLRequest.HTTPVerb = .GET, requestModel: RequestModel, contentType: URLRequest.ContentType = .others) {
        self.url = url
        self.httpVerb = httpVerb
        self.requestModel = requestModel
        self.contentType = contentType
    }
}
