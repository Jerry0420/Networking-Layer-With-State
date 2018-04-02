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
protocol APIEndPointProtocol {
    func provideValues()-> APIRequestValues
    var url: String { get }
    var httpVerb: URLRequest.HTTPVerb { get }
    var parameters: [String: Any]? { get }
    var header: [String: String]? { get }
    var contentType: URLRequest.ContentType { get }
}

extension APIEndPointProtocol {
    var url: String { return provideValues().url }
    var httpVerb: URLRequest.HTTPVerb { return provideValues().httpVerb }
    var parameters: [String: Any]? { return provideValues().parameters }
    var header: [String: String]? { return provideValues().header }
    var contentType: URLRequest.ContentType { return provideValues().contentType }
}

struct APIRequestValues {
    let url: String
    let httpVerb: URLRequest.HTTPVerb
    let parameters: [String: Any]?
    let header: [String: String]?
    let contentType: URLRequest.ContentType
    
    init (url: String, httpMethod: URLRequest.HTTPVerb = .GET, parameters: [String: Any]? = nil, header: [String: String]? = nil, contentType: URLRequest.ContentType = .others) {
        self.url = url
        self.httpVerb = httpMethod
        self.parameters = parameters
        self.header = header
        self.contentType = contentType
    }
}
