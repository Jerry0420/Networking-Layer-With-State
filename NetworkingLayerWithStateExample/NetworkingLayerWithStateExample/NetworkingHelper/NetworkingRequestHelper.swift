//
//  NetworkingRequestHelper.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2017/2/27.
//  Copyright © 2017年 Jerrywang. All rights reserved.
//

import Foundation

extension URLRequest{
    
    // MARK: - Public option
    ///Content Type for URLRequest
    enum ContentType : String{
        case json = "application/json"
        case formData = "multipart/form-data"
        case urlencoded = "application/x-www-form-urlencoded"
        case others = ""
    }
    ///HttpVerb for URLRequest
    enum HTTPVerb: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case HEAD = "HEAD"
        case DELETE = "DELETE"
        case PATCH = "PATCH"
        case OPTIONS = "OPTIONS"
        case TRACE = "TRACE"
        case CONNECT = "CONNECT"
        case UNKNOWN = "UNKNOWN"
    }
    ///HTTPMimeType for URLRequest
    enum HTTPMimeType : String {
        case imageJpeg = "image/jpeg"
        case imagePng = "image/png"
    }
}

// MARK: - HTTPService
///Generate url request
struct HTTPService{
    private init() {}
    static func generateRequest(with api: APIEndPointProtocol) -> URLRequest{
        let apiValues = api.provideValues()
        var urlComponents = URLComponents(string: apiValues.url)!
        urlComponents.queryItems = []
        
        if let parameters = apiValues.requestModel.parameters {
            for (key, value) in parameters{
                urlComponents.queryItems?.append(URLQueryItem(name: key, value: (value as! String)))
            }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        
        if let headers = apiValues.requestModel.header {
            for (key,value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
