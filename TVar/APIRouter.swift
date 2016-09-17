//
//  APIRouter.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    static let baseURL = "https://veat-api.herokuapp.com"
    static var token: String?
    
    case FacebookLogin([String:String])
    case GetHomeFeed
    case LoadHomeFeed(Int)
    case GetUploadID([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self{
        case .FacebookLogin:
            return .POST
        case .GetHomeFeed:
            return .GET
        case .LoadHomeFeed:
            return .GET
        case .GetUploadID:
            return .POST
        }
    }
    
    var path: String{
        switch self {
        case .FacebookLogin:
            return "/authenticate/facebook"
        case .GetHomeFeed:
            return "/videos"
        case .LoadHomeFeed:
            return "/videos"
        case .GetUploadID:
            return "/videos"
        }
    }
    
    var URLRequest: NSMutableURLRequest{
        let URL = NSURL(string:  APIRouter.baseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        if let auth = APIRouter.token{
            mutableURLRequest.setValue(auth, forHTTPHeaderField: "X-User-Token")
        }
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch self{
        case .FacebookLogin(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .LoadHomeFeed(let page):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["page": page]).0
        case .GetUploadID(let params):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        default:
            return mutableURLRequest
        }
    }
}
