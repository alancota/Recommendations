//
//  AddRecommendationViewController.swift
//  Recommendations
//
//  Created by Alan Cota on 8/11/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AddRecommendationViewController: UIViewController {

    // Class properties
    @IBOutlet weak var txtProductCode: UITextField!
    @IBOutlet weak var txtRecProdCode: UITextField!
    @IBOutlet weak var txtRecProdName: UITextField!
    @IBOutlet weak var btnCallAPI: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnCallAPITapped(_ sender: Any) {
        
        addRecommendation()
        
    }
    
    
    
    
    // Function to make a POST to the LAC Recommendations table API
    func addRecommendation() {
        
        
        let httpParams = ["productCode":self.txtProductCode.text!, "r_productCode":txtRecProdCode.text!, "r_productName":txtRecProdName.text!]
        
        print(httpParams)
        
        let httpHeaders: HTTPHeaders = [
            Common.Demo.demoAPICustomerListAuthHeader: Common.Demo.demoAPIRecommendationAuthHeaderValue,
            "Accept": "application/json",
            "Content-Type":"application/json"
        ]

        SVProgressHUD.show(withStatus: "Adding the new recommendation, please wait...")
        Alamofire.request(Common.Demo.demoAPIRecommendation, method: .post, parameters: httpParams, encoding: JSONEncoding.default, headers: httpHeaders).responseJSON { response in
        
            SVProgressHUD.dismiss()
            
            switch (response.result) {
            case .success(let _):
                print("Recommendation added!")
                
                // Success
                let alertController = UIAlertController(title: "Add new recommendation", message: Common.Dialogs.newRecommendation + " - [\(self.txtProductCode.text!)]", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
            case .failure(let error):
                print("Error adding recommendation >>> \(error)")
                
                // Error
                let alertController = UIAlertController(title: "Error", message: Common.Error.error1001 + " - [\(error)]", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion: nil)
            
        }
        }


    
    }
}
