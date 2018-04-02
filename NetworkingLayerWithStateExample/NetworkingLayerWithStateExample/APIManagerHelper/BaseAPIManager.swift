//
//  BaseAPIManager.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/3.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import Foundation

// MARK: - Handle url, parameters, header, method
enum MemberAPI {
    
    ///BaseURL Endpoint(parameter, header)
    case signUp(key1: String, key2: String, header: String)
    case signIn(key1: String, key2: String, header: String)
    case signOut(key1: String, key2: String, header: String)
    
    ///Combinate all urls with their own endpoint.
    fileprivate var urlString : String {
        var endPoint = ""
        switch self {
        case .signUp: endPoint = "/signUp"
        case .signIn: endPoint = "/signIn"
        case .signOut: endPoint = "signOut"
        }
        return "https://memberBaseURL.com" + endPoint
    }
    
    fileprivate func fetchSignUpParameters(key1: String, key2: String, header: String)->(parameters: [String : Any], header: [String: String]) {
        return (parameters: ["signUpAccount" : key1, "signUpPassword": key2 ], header: ["token": header])
    }
    fileprivate func fetchSignInParameters(key1: String, key2: String, header: String)->(parameters: [String : Any], header: [String: String]) {
        return (parameters: ["signInAccount" : key1, "signInPassword": key2 ], header: ["token": header])
    }
    fileprivate func fetchSignOutParameters(key1: String, key2: String, header: String)->(parameters: [String : Any], header: [String: String]) {
        return (parameters: ["signOutAccount" : key1, "signOutPassword": key2 ], header: ["token": header])
    }
}

extension MemberAPI: APIEndPointProtocol {
    func provideValues() -> APIRequestValues {
        
        switch self {
        case .signUp(key1: let value1, key2: let value2, header: let headerValue):
            let results = fetchSignUpParameters(key1: value1, key2: value2, header: headerValue)
            return APIRequestValues(url: urlString, httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
            
        case .signIn(key1: let value1, key2: let value2, header: let headerValue):
            let results = fetchSignInParameters(key1: value1, key2: value2, header: headerValue)
            return APIRequestValues(url: urlString, httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
            
        case .signOut(key1: let value1, key2: let value2, header: let headerValue):
            let results = fetchSignOutParameters(key1: value1, key2: value2, header: headerValue)
            return APIRequestValues(url:urlString)
        }
    }
}

// MARK: - Handle url, parameters, header, method
enum ShowAPI {
    
    ///BaseURL Endpoint(parameter, header)
    case join(key1: String, key2: String, header: String)
    case exit(key1: String, key2: String, header: String)
    
    ///Combinate all urls with their own endpoint.
    fileprivate var urlString : String {
        var endPoint = ""
        switch self {
        case .join: endPoint = "/join"
        case .exit: endPoint =  "/exit"
        }
        return "https://showBaseURL.com" + endPoint
    }
    
    fileprivate func fetchJoinParameters(key1: String, key2: String, header: String)->(parameters: [String : Any], header: [String: String]) {
        return (parameters: ["joinShowID" : key1, "time": key2 ], header: ["token": header])
    }
    
    fileprivate func fetchExitParameters(key1: String, key2: String, header: String)->(parameters: [String : Any], header: [String: String]) {
        return (parameters: ["exitShowID" : key1, "time": key2 ], header: ["token": header])
    }
}

extension ShowAPI: APIEndPointProtocol {
    func provideValues() -> APIRequestValues {
        
        switch self {
        case .join(key1: let value1, key2: let value2, header: let headerValue):
            let results = fetchJoinParameters(key1: value1, key2: value2, header: headerValue)
            return APIRequestValues(url: urlString, httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
        case .exit(key1: let value1, key2: let value2, header: let headerValue):
            let results = fetchExitParameters(key1: value1, key2: value2, header: headerValue)
            return APIRequestValues(url:urlString)
        }
    }
}
