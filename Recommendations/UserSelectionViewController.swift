//
//  UserSelectionViewController.swift
//  Recommendations
//
//  Created by Alan Cota on 8/4/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class UserSelectionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, URLSessionDelegate {
    
    // Initiate the Service class as a singleton
    let service = Service.sharedInstance
    
    // User Defaults to define some demo information
    let defaults = UserDefaults.standard
    
    //Class properties
    @IBOutlet weak var userPicker: UIPickerView!
    @IBOutlet weak var tokenPresentButton: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnSeeRecommendation: UIButton!

    
    // Initialize the CustomerObject to store the retrieved customername and customernumber from LAC
    var customers = [CustomerObject]()
    var selectedIndex = 0
    //
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check if an access_token is present
        if (self.defaults.string(forKey: "access_token")?.isEmpty)! {
            
            // If the user defaults key access_token is empty, update the message label
            self.lblMessage.text = "Get an access_token first!"
            self.lblMessage.isHidden = false
            self.tokenPresentButton.setImage(#imageLiteral(resourceName: "notoken"), for: .normal)
            self.btnSeeRecommendation.isEnabled = false
            
        } else {
            self.lblMessage.isHidden = true
            self.tokenPresentButton.setImage(#imageLiteral(resourceName: "tokenpresent"), for: .normal)
            self.btnSeeRecommendation.isEnabled = true
        }
        
    }
    
    // Main Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect PickerList to its data
        self.userPicker.dataSource = self
        self.userPicker.delegate = self
        
        
  
        // Fetch the list of customers out of the LAC
        self.getCustomers()
        
        
    }

    // Token present button tapped. I will show a popup with the current access token
    @IBAction func tokenPresentButtonTapped(_ sender: Any) {
        
    }

    
    // PickerView delegate methods
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.customers.count
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let customer = self.customers[row]
        selectedIndex = row
        return customer.customerName
    }
    
    // MARK: Fetch the customer list (name + number) to be used with the picker list
    func getCustomers() {
        
        let headers: HTTPHeaders = [
            Common.Demo.demoAPICustomerListAuthHeader: Common.Demo.demoAPICustomerListAuthHeaderValue,
            "Accept": "application/json"
        ]
 
        
        service.getAPI(uri: Common.Demo.demoAPICustomerList, headers: headers, stopProgress: true, success: { (response) in
            
            print(response)
            for (key,subJson):(String, JSON) in response as JSON {
                self.customers.append(CustomerObject(json: subJson))
            }
            self.userPicker.reloadAllComponents()
            
        }, failure: { (error) in
            
            print(error)
            
        })
 
    }
    
    // MARK: - Prepare to segue when the see recommendation button is tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPurchases" {
              let controller = segue.destination as! PurchaseListTableViewController
              controller.customerNumber = self.customers[selectedIndex].customerNumber

        }
        
    }

    
}
