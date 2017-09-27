//
//  MainViewController.swift
//  Recommendations
//
//  Created by Alan Cota on 8/10/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import UIKit
import MASFoundation

class MainViewController: UIViewController {

    // Class properties
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    @IBOutlet weak var btnLogin: UIBarButtonItem!
    @IBOutlet weak var lblUserDemoExp: UILabel!
    @IBOutlet weak var btnDemoOTK: UIButton!
    @IBOutlet weak var btnDemoAddRec: UIButton!
    
    
    
    // User Defaults to define some demo information
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MAS Start
        MAS.setGrantFlow(MASGrantFlow.password)
        SVProgressHUD.show(withStatus: "Initializaing MAG, please wait...")
        MAS.start(withDefaultConfiguration: true) { (completed: Bool, error: Error?) in
        
            SVProgressHUD.dismiss()
            
            if (error != nil) {
                print ("MAS Start error: " + error.debugDescription)
            }
        
            
            self.userLogin()
            
        }
        
    }
    
    //
    // This function will check the authenticated user to define which screen present next
    func checkUser() {
    
        if (MASUser.current()?.isAuthenticated)! {
            self.btnDemoOTK.isEnabled = true
            self.btnDemoAddRec.isEnabled = true
        } else {
            self.btnDemoOTK.isEnabled = false
            self.btnDemoAddRec.isEnabled = false
        }
        

        
    }
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
        
        self.userLogout()
        self.btnLogout.isEnabled = false
        self.btnLogin.isEnabled = true
        self.lblUserDemoExp.text = "Please login in order to select your demo experience"
       
    }

    @IBAction func btnLoginTapped(_ sender: Any) {
        
        self.userLogin()
        self.btnLogin.isEnabled = false
        self.btnLogout.isEnabled = true
        //self.lblUserDemoExp.text = "Hello, " + MASUser.current()!.userName + ". Please select your demo experience below"
        
    }
    
    
    func userLogin() {
        // This is trigger the SDK to show the authentication screen
        
       // SVProgressHUD.show(withStatus: "Starting the user authentication, please wait...")
        MAS.getFrom("/protected/resource/products", withParameters: ["operation":"listProducts"], andHeaders: nil, completion: { (response, error) in
            
         //   SVProgressHUD.dismiss()
            
            if (error != nil) {
                print("MAS User AuthN error: " + error.debugDescription)
            }
            
            self.btnLogin.isEnabled = false
            
            self.btnDemoOTK.isEnabled = true
            self.btnDemoAddRec.isEnabled = true
            
            self.lblUserDemoExp.text = "Hello, " + MASUser.current()!.userName + ". Please select your demo experience below"
        })
    }
    
    func userLogout() {
        if (MASUser.current() != nil) {
            SVProgressHUD.show(withStatus: "Logging out the user, please wait...")
            MASUser.current()?.logout(completion: { (completed: Bool, error: Error?) in
                
                SVProgressHUD.dismiss()
                
                //Error
                if (error != nil) {
                    print(error.debugDescription)
                    
                }
                
                self.btnDemoOTK.isEnabled = false
                self.btnDemoAddRec.isEnabled = false
                
            })
            
        }
    }
    
    // MARK: - Depending on the user it will process different segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // IF the user is the Admin, then perform a segue to the customer picker
        if (MASUser.current() != nil) {
            if (MASUser.current()!.userName == "admin") {
                self.performSegue(withIdentifier: "secureDemoExperience", sender: self)
            } else {
                // Not Admin
                let controller:PurchaseListTableViewController = PurchaseListTableViewController()
                controller.customerNumber = "103"
                self.present(controller, animated: true, completion: nil)
            }
        }

        
    }
    
}
