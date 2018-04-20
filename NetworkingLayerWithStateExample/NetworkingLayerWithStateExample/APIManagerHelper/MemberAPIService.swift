//
//  HttpbinAPIManager.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/4.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import Foundation

// MARK: - Public method for MemberAPIBaseURL
struct MemberAPIService: RequestManager {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func signUp<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let apiInformation = MemberAPI.signUp(key1: key1, key2: key2, header: header)
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
    
    func signIn<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let apiInformation = MemberAPI.signIn(key1: key1, key2: key2, header: header)
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
    
    func signOut<T>(key1: String, key2: String, header: String, model: T.Type, _ completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        
        let apiInformation = MemberAPI.signOut(key1: key1, key2: key2, header: header)
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
}
