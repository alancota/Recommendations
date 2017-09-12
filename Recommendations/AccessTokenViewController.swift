//
//  AccessTokenViewController.swift
//  Recommendations
//
//  Created by Alan Cota on 8/10/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AccessTokenViewController: UIViewController {

    // Class properties
    @IBOutlet weak var lblCurrentAccessToken: UILabel!
    @IBOutlet weak var btnRefreshToken: UIButton!
    @IBOutlet weak var btnClearToken: UIButton!
    
    // Initiate the Service class as a singleton
    let service = Service.sharedInstance
    let defaults = Service.defaults
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if !((defaults.string(forKey: "access_token")?.isEmpty)!) {
                self.lblCurrentAccessToken.text = defaults.string(forKey: "access_token")
        }
        
    }

    // Get a new access token
    @IBAction func btnRefreshTokenTapped(_ sender: Any) {
        
        self.getAccessToken()
        
    }
    
    // Clear the existing token
    
    @IBAction func btnClearTokenTapped(_ sender: Any) {
        
        defaults.set("", forKey: "access_token")
        self.lblCurrentAccessToken.text = "You have no access_token!"
        
    }
    
    
    //
    // This function will fetch an access_token to be used to securely call the APIs (part of the secure demo experience)
    func getAccessToken() {
        
        SVProgressHUD.show(withStatus: "Securing your demo experience with an OAuth access_token, please wait...")
        
        let httpParams : [String:Any]? = ["client_id":Common.OAuth.oauthClientId, "client_secret":Common.OAuth.oauthClientSecret, "scope":Common.OAuth.oauthScope, "grant_type":Common.OAuth.oauthGrantType, "username":Common.OAuth.oauthUsername, "password":Common.OAuth.oauthPassword]

        service.postAPI(uri: Common.OAuth.oauthTokenEndpoint, params: httpParams!, stopProgress: true, success: { (accessTokenResponse) in
            
            print(accessTokenResponse)
            self.lblCurrentAccessToken.text = accessTokenResponse
            
        }) { (error) in
            print(error)
        }
        
        print("Access token saved!")
    }
    
}
