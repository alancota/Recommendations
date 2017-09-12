//
//  Service.swift
//  Recommendations
//
//  Created by Alan Cota on 8/17/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

typealias Functions = Service

final class Service {
    
    // Singleton object
    static let sharedInstance = Service()
    //private let manager = Networking.manager
    
    // User Defaults to define some demo information
    static let defaults = UserDefaults.standard

    private init() {
        
        print("Service Class initiated")
        
    }
    
}

// Functions
extension Functions {
   
    func addUserDefaults(value: String, key: String) {
        
        Service.defaults.set(value, forKey: key)
        
    }
    
    
    func HttpRequest(url: String,
                     method: HTTPMethod,
                     parameters: [String:Any],
                     headers: HTTPHeaders,
                     success: (JSON) -> Void,
                     failure: (NSError) -> Void) {
        
        Networking.manager.request(url, method: method, parameters: parameters, headers: headers).validate().responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                
                success(JSON(value))
                
            case .failure(let error):
                print(error)
                failure((error as NSError?)!)
            }
            
        }
        
    }
    
    func getAccessToken(grantType: String,
                        clientID: String,
                        clientSecret: String,
                        scope: String,
                        userName: String,
                        userPassword: String,
                        success:@escaping (String) -> Void,
                        failure:@escaping (NSError) -> Void) {
     
        
        
    }
    
    // ****************************************************************************************************
    //
    //
    // MARK: - POST HTTP Request
    // This function will execute a post and return an access_token
    // Parameters:
    //
    //      uri             --> URL to perform the HTTP GET
    //      headers         --> HTTP Headers to be sent (it can be nil)
    //      stopProgress    --> IF SVProgressHUD has been initialized before call the function
    //
    // ****************************************************************************************************
    func postAPI(uri: String, params: [String:Any], stopProgress: Bool, success:@escaping (JSON) -> Void, failure:@escaping (NSError) -> Void) {
        
        Networking.manager.request(uri, method: .post, parameters: params).validate().responseJSON {
            response in
            
            if (stopProgress) {
                SVProgressHUD.dismiss()
            }
            
            switch (response.result) {
            case .success(let value):
                let atResponse = JSON(value)
                print("Access Token response: \(atResponse)")
                
                self.addUserDefaults(value: atResponse["access_token"].stringValue, key: "access_token")
                success(atResponse["access_token"].stringValue)
                
            case .failure(let error):
                print("Error obtaining an access_token >>> \(error)")
                failure((error as NSError?)!)
            }
        }
    }
    
    func getCustomers(httpHeaders: HTTPHeaders,
                      httpUrl: String,
                      success:@escaping (CustomerObject) -> Void,
                      failure:@escaping (NSError) -> Void) {
        
                
    }

    // ****************************************************************************************************
    //
    //
    // MARK: - GET HTTP Request
    // This function will return a SwiftyJSON object
    // Parameters:
    //
    //      uri             --> URL to perform the HTTP GET
    //      headers         --> HTTP Headers to be sent (it can be nil)
    //      stopProgress    --> IF SVProgressHUD has been initialized before call the function
    //
    // ****************************************************************************************************
    func getAPI(uri: String, headers: HTTPHeaders, stopProgress: Bool, success:@escaping (JSON) -> Void, failure:@escaping (NSError) -> Void) {
        
        // Make the call using Alamofire
        Alamofire.request(uri, method: .get, headers: headers).validate().responseJSON { response in
            
            // If
            if (stopProgress) {
                SVProgressHUD.dismiss()
            }
            switch response.result {
            case .success(let value):
                
                success(JSON(value))
                
            case .failure(let error):
                print(error)
                failure((error as NSError?)!)
            }
        }
    }
}
