//
//  JSONManager.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/5.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import Foundation

typealias ResultCompletionHandler<T: Codable> = (ResponseState<T>)->()
typealias responseContent = (data: Data?, response:  URLResponse?, url: URL, error: Error?)

protocol ResponseManager {
    ///for D.I.
    init(session: URLSessionProtocol)
    
    ///Response check
    func handle<T>(with responseContent: responseContent, model: T.Type, completionHandler: ResultCompletionHandler<T>)
}

extension ResponseManager {
    
    func handle<T>(with responseContent: responseContent, model: T.Type, completionHandler: ResultCompletionHandler<T>) {

        guard responseContent.error == nil else {
            completionHandler(ResponseState.failure(NetworkingError.error(responseContent.error!)))
            return
        }
        guard let response = responseContent.response, let data = responseContent.data else {
            completionHandler(ResponseState.failure(NetworkingError.responseAndDataNil))
            return
        }
        guard responseContent.url == response.url else {
            completionHandler(ResponseState.failure(NetworkingError.urlDismatch))
            return
        }
        
        guard 200...299 ~= (response as! HTTPURLResponse).statusCode else {
            completionHandler(ResponseState.failure(NetworkingError.statusCodeError((response as! HTTPURLResponse).statusCode)))
            return
        }
        
        //success part
        guard let dataModel = try? JSONDecoder().decode(T.self, from: data) else{
            completionHandler(ResponseState.failure(NetworkingError.jsonParseFail))
            return
        }
        completionHandler(ResponseState.success(dataModel))
    }
}
