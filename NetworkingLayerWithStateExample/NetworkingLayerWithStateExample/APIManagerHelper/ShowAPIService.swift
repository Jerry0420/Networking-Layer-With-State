//
//  ShowAPIManager.swift
//  NetworkingLayerWithStateExample
//
//  Created by JerryWang on 2018/3/22.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import Foundation

// MARK: - Public method for BaseURL
struct ShowAPIService: RequestManager {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func join<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let apiInformation = ShowAPI.join(key1: key1, key2: key2, header: header)
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
    
    func exit<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let apiInformation = ShowAPI.exit(key1: key1, key2: key2, header: header)
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
}
