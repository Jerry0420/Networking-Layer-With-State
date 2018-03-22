//
//  BaseAPIManager.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/3.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import Foundation

// MARK: - Handle url, parameters, header, method
enum ServiceAPI {
    ///BaseURL
    case memberBaseURL(MemberBaseURLEndPoint)
    case showBaseURL(ShowBaseURLEndPoint)
    
    ///BaseURL Endpoint(parameter, header)
    enum MemberBaseURLEndPoint {
        case signUp(key1: String, key2: String, header: String)
        case signIn(key1: String, key2: String, header: String)
        case signOut(key1: String, key2: String, header: String)
        
        fileprivate var rawValue : String {
            switch self {
            case .signUp: return "/signUp"
            case .signIn: return "/signIn"
            case .signOut: return "signOut"
            }
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
    
    enum ShowBaseURLEndPoint {
        case join(key1: String, key2: String, header: String)
        case exit(key1: String, key2: String, header: String)
        
        fileprivate var rawValue : String {
            switch self {
            case .join: return "/join"
            case .exit: return "/exit"
            }
        }
        
        fileprivate func fetchJoinParameters(key1: String, key2: String, header: String)->(parameters: [String : Any], header: [String: String]) {
            return (parameters: ["joinShowID" : key1, "time": key2 ], header: ["token": header])
        }
        
        fileprivate func fetchExitParameters(key1: String, key2: String, header: String)->(parameters: [String : Any], header: [String: String]) {
            return (parameters: ["exitShowID" : key1, "time": key2 ], header: ["token": header])
        }
    }
    
    ///Combinate all urls with their own endpoint.
    fileprivate func urlBuilder() -> String {
        switch self {
        case .memberBaseURL(let endpoint):
            return "https://memberBaseURL.com" + endpoint.rawValue
        case .showBaseURL(let endpoint):
            return "https://showBaseURL.com" + endpoint.rawValue
        }
    }
}

extension ServiceAPI: APIEndPointProtocol {
    func provideValues() -> (url: String, httpMethod: URLRequest.HTTPVerb, parameters: [String : Any]?, header: [String : String]?, contentType: URLRequest.ContentType) {
        switch self {
        case .memberBaseURL(let endPoint):
            switch endPoint {
            case .signUp(key1: let value1, key2: let value2, header: let headerValue):
                let results = endPoint.fetchSignUpParameters(key1: value1, key2: value2, header: headerValue)
                return (url: ServiceAPI.memberBaseURL(endPoint).urlBuilder(), httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
            
            case .signIn(key1: let value1, key2: let value2, header: let headerValue):
                let results = endPoint.fetchSignInParameters(key1: value1, key2: value2, header: headerValue)
                return (url: ServiceAPI.memberBaseURL(endPoint).urlBuilder(), httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
                
            case .signOut(key1: let value1, key2: let value2, header: let headerValue):
                let results = endPoint.fetchSignOutParameters(key1: value1, key2: value2, header: headerValue)
                return (url: ServiceAPI.memberBaseURL(endPoint).urlBuilder(), httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
                
            }
        case .showBaseURL(let endPoint):
            switch endPoint {
            case .join(key1: let value1, key2: let value2, header: let headerValue):
                let results = endPoint.fetchJoinParameters(key1: value1, key2: value2, header: headerValue)
                return (url: ServiceAPI.showBaseURL(endPoint).urlBuilder(), httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
            case .exit(key1: let value1, key2: let value2, header: let headerValue):
                let results = endPoint.fetchExitParameters(key1: value1, key2: value2, header: headerValue)
                return (url: ServiceAPI.showBaseURL(endPoint).urlBuilder(), httpMethod: .GET, parameters: results.parameters, header: results.header, contentType: .others)
            }
        }
    }
}
