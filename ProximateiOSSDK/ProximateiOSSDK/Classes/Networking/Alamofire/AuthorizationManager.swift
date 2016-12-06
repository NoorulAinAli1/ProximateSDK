//
//  AuthorizationManager.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 18/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import Foundation

public class AuthorizationManager: Manager {
    private let OAUTH_EXPIRY_CODE  : NSNumber! = 401
    public typealias NetworkSuccessHandler = (NSDictionary?) -> Void
    public typealias NetworkFailureHandler = (NSHTTPURLResponse?, AnyObject?, NSError) -> Void
    
    private typealias CachedTask = (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void
    
    private var cachedTasks = Array<CachedTask>()
    private var isRefreshing = false
    
    public static let sharedManager: AuthorizationManager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        
        return AuthorizationManager(configuration: configuration)
    }()
    
    public func startRequest(
        method method: Method,
               var URLString: URLStringConvertible,
               parameters: [String: AnyObject]?,
               encoding: ParameterEncoding,
               success: NetworkSuccessHandler?,
               failure: NetworkFailureHandler?) -> Request?
    {
        let cachedTask: CachedTask = { [weak self] URLResponse, data, error in
            guard let strongSelf = self else { return }

            if let error = error {
                failure?(URLResponse, data, error)
            } else {
                strongSelf.startRequest(
                    method: method,
                    URLString: URLString,
                    parameters: parameters,
                    encoding: encoding,
                    success: success,
                    failure: failure
                )
            }
        }
        
        DebugLogger.debugLog("URLString \(URLString)")
        DebugLogger.debugLog("parameters \(parameters)")
        
        if self.isRefreshing {
//            URLString = self.replaceOauthToken(URLString.URLString)
        }
        
        // Append auth tokens here
       let request = self.request(method, URLString, parameters: parameters, encoding: encoding)
        
        request.response { [weak self] request, response, data, error in
            guard let strongSelf = self else { return }
         
            if let response = response where response.statusCode == self!.OAUTH_EXPIRY_CODE {
                strongSelf.cachedTasks.append(cachedTask)
                strongSelf.refreshTokens()
                return
            }
            
            if let error = error {
                failure?(response, data, error)
            } else {
                do {
                    let JSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as! NSDictionary
                    success?(JSON)

                } catch let errorJSON as NSError {
                    failure?(response, data, errorJSON)
                }
            }
        }
        
        return request
    }
    
    func refreshTokens() {
        self.isRefreshing = true
        
//        ApiHandler.sharedInstance.getOauthTokenFromRefreshToken({
//            retry in
//                        
//            if retry {
//                let cachedTaskCopy = self.cachedTasks
//                self.cachedTasks.removeAll()
//                cachedTaskCopy.map { $0(nil, nil, nil) }
//                self.isRefreshing = false
//
//            } else {
//                
//            }
//            
//        })
    }
    
//    func replaceOauthToken(url : String) -> String {
//        let completeURL = url.componentsSeparatedByString("?access_token")
//        return "\(completeURL[0])\(ApiWebURLs.addOauthTokenSuffix())"
//    }
}
