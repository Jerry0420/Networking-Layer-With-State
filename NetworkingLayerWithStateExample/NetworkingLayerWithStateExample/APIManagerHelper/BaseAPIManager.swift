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
        var tempParameters = [String : Any]()
        var tempHeader = [String: String]()
        switch self {
        case let .signUp (key1: key1, key2: key2, header: header):
            tempParameters["signUpAccount"] = key1
            tempParameters["signUpPassword"] = key2
            tempHeader["token"] = header
        default:
            break
        }
        return (parameters: tempParameters, header: tempHeader)
    }
    fileprivate func fetchSignInParameters() -> RequestModel {
        var tempParameters = [String : Any]()
        var tempHeader = [String: String]()
        switch self {
        case let .signIn (key1: key1, key2: key2, header: header):
            tempParameters["signInAccount"] = key1
            tempParameters["signInPassword"] = key2
            tempHeader["token"] = header
        default:
            break
        }
        return (parameters: tempParameters, header: tempHeader)
    }
    fileprivate func fetchSignOutParameters() -> RequestModel {
        var tempParameters = [String : Any]()
        var tempHeader = [String: String]()
        switch self {
        case let .signOut (key1: key1, key2: key2, header: header):
            tempParameters["signOutAccount"] = key1
            tempParameters["signOutPassword"] = key2
            tempHeader["token"] = header
        default:
            break
        }
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
        var tempParameters = [String : Any]()
        var tempHeader = [String: String]()
        switch self {
        case let .join (key1: key1, key2: key2, header: header):
            tempParameters["joinShowID"] = key1
            tempParameters["time"] = key2
            tempHeader["token"] = header
        default:
            break
        }
        return (parameters: tempParameters, header: tempHeader)
    }
    
    fileprivate func fetchExitParameters() -> RequestModel {
        var tempParameters = [String : Any]()
        var tempHeader = [String: String]()
        switch self {
        case let .exit (key1: key1, key2: key2, header: header):
            tempParameters["exitShowID"] = key1
            tempParameters["time"] = key2
            tempHeader["token"] = header
        default:
            break
        }
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
