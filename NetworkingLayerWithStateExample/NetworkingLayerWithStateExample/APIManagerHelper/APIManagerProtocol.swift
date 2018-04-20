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
    var url: String { get }
    var httpVerb: URLRequest.HTTPVerb { get }
    var requestModel: RequestModel { get }
    var contentType: URLRequest.ContentType { get }
}

extension APIEndPointProtocol {
    var url: String { return provideValues().url }
    var httpVerb: URLRequest.HTTPVerb { return provideValues().httpVerb }
    var requestModel: RequestModel { return provideValues().requestModel }
    var contentType: URLRequest.ContentType { return provideValues().contentType }
}

struct APIRequestValues {
    let url: String
    let httpVerb: URLRequest.HTTPVerb
    let requestModel: RequestModel
    let contentType: URLRequest.ContentType
    
    init (url: String, httpVerb: URLRequest.HTTPVerb = .GET, requestModel: RequestModel = (parameters: nil, header: nil), contentType: URLRequest.ContentType = .others) {
        self.url = url
        self.httpVerb = httpVerb
        self.requestModel = requestModel
        self.contentType = contentType
    }
}
