//
//  Common.swift
//  Recommendations
//
//  Created by Alan Cota on 8/4/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//
//  This class is used to configure your demo experience
//

import UIKit

class Common: NSObject {

   //Demo Configuration
    struct Demo {
        // List of users to be picked at the user selection screen
        static let demoUserPickList = ["Alan", "Daniel", "Alana"]
        
        // LAC API used to fetch a list of all customers and their respective number
        static let demoAPICustomerList = "http://localhost:8111/rest/default/svcOrders/v1/orders:customers"
        
        // Customer API authorization header name
        static let demoAPICustomerListAuthHeader = "Authorization"
        
        // Customer API authorization header value
        static let demoAPICustomerListAuthHeaderValue = "CALiveAPICreator zFeg53T5ESosM2xqM86s:1"
        
        // API to retrieve the purchases of a specific customerNumber - Below the URI BEFORE the customerNumber
        static let demoAPICustomerPurchasesBeforeCustomerNumber = "http://localhost:8080/recSvc/v1/users/"
        
        // API to retrieve the purchases of a specific customerNumber - Below the URI AFTER the customerNumber
        static let demoAPICustomerPurchasesAfterCustomerNumber = "/orders"
        
        // Name of the image used inside the recommendation's tableview. It MUST match the name inside the Assets.xcassets
        static let demoRecommendationImage = "recommendation"
        
        // Main Screen Buttons
        static let demoMainButtonSecure = "Secure"
        static let demoMainButtonUnsecure = "Unsecure"
        
        // User Defaults Key for the secure or unsecure demo experience
        static let demoExperienceDefaultsKey = "secure"
    }
    
    //OAuth Information to obtain an access_token
    struct OAuth {
        
        // Token Endpoint
        static let oauthTokenEndpoint = "https://localhost:8443/auth/oauth/v2/token"
        
        // Parameter: client_id
        static let oauthClientId = "clientkey"
        
        // Parameter: client_secret
        static let oauthClientSecret = "clientsecret"
        
        // Parameter: scope
        static let oauthScope = "oob"
        
        // Parameter: grant_type
        static let oauthGrantType = "password"
        
        // Parameter: username
        static let oauthUsername = "arose"
        
        // Parameter: password
        static let oauthPassword = "StRonG5^)"
        
    }
    
}
