//
//  Service.swift
//  Recommendations
//
//  Created by Alan Cota on 9/27/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import MASFoundation
import MASUI

typealias Functions = Service

final class Service {
    
    // Singleton object
    static let sharedInstance = Service()
    
    static let defaults = UserDefaults.standard
    
    private init() {
        
        print("Service Class started")
        
    }
    
}

extension Functions {
    
    func httpGet(uri: String, parameters: [Any: Any], headers: [Any: Any],success:@escaping (JSON) -> Void, failure:@escaping (NSError) -> Void) {
        
        MAS.getFrom(uri, withParameters: parameters, andHeaders: headers, completion: { (response, error) in
            
            // Error
            if (error != nil) {
                print("Error calling the HTTP GET API: " + error.debugDescription)
                failure((error))
            }
            
           // Success
           success(JSON(response))
            
        })
        
    }
    
}
