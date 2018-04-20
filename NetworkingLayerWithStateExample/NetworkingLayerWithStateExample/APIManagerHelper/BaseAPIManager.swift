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
    
    fileprivate func fetchSignUpParameters() -> RequestModel {
        guard case let .signUp (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["signUpAccount": key1, "signUpPassword": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
    fileprivate func fetchSignInParameters() -> RequestModel {
        guard case let .signIn (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["signInAccount": key1, "signInPassword": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
    fileprivate func fetchSignOutParameters() -> RequestModel {
        guard case let .signOut (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["signOutAccount": key1, "signOutPassword": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
}

extension MemberAPI: APIEndPointProtocol {
    func provideValues() -> APIRequestValues {
        
        var apiRequestValues: APIRequestValues
        
        switch self {
        case .signUp:
            apiRequestValues = APIRequestValues(url: urlString, httpVerb: .POST, requestModel: fetchSignUpParameters(), contentType: .urlencoded)
        case .signIn:
            apiRequestValues = APIRequestValues(url: urlString, httpVerb: .POST, requestModel: fetchSignInParameters(), contentType: .urlencoded)
        case .signOut:
            apiRequestValues = APIRequestValues(url: urlString, httpVerb: .POST, requestModel: fetchSignOutParameters(), contentType: .urlencoded)
        }
        return apiRequestValues
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
    
    fileprivate func fetchJoinParameters() -> RequestModel {
        guard case let .join (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["joinShowID": key1, "time": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
    
    fileprivate func fetchExitParameters() -> RequestModel {
        guard case let .exit (key1: key1, key2: key2, header: header) = self else { return (nil, nil) }
        let tempParameters: [String : Any] = ["exitShowID": key1, "time": key2]
        let tempHeader: [String: String] = ["token": header]
        return (parameters: tempParameters, header: tempHeader)
    }
}

extension ShowAPI: APIEndPointProtocol {
    func provideValues() -> APIRequestValues {
        
        var apiRequestValues: APIRequestValues
        
        switch self {
        case .join:
            apiRequestValues = APIRequestValues(url: urlString, httpVerb: .POST, requestModel: fetchJoinParameters(), contentType: .urlencoded)
        case .exit:
            apiRequestValues = APIRequestValues(url: urlString, httpVerb: .POST, requestModel: fetchExitParameters(), contentType: .urlencoded)
        }
        return apiRequestValues
    }
}
