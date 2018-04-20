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

protocol RequestManager {
    var session: URLSessionProtocol { get }
    ///for D.I.
    init(session: URLSessionProtocol)
}

extension RequestManager {
    
    func generateTask<T>(with apiInformation: APIEndPointProtocol, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let request = HTTPService.generateRequest(with: apiInformation)
        let task = session.dataTask(with: request) { (data, response, url, error) in
            self.handleResponse(with: (data, response, url, error), model: model, completionHandler: completionHandler)
        }
        return task
    }
    ///Response check
    func handleResponse<T>(with responseContent: responseContent, model: T.Type, completionHandler: ResultCompletionHandler<T>) {

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
