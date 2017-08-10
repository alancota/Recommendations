//
//  PurchaseListTableViewController.swift
//  Recommendations
//
//  Created by Alan Cota on 8/7/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PurchaseListTableViewController: UITableViewController {

    // MARK: - Class Properties
    
    // User Defaults to define some demo information
    let defaults = UserDefaults.standard
    
    // Customer Number received from the customer picker screen
    var customerNumber = ""
    // Object to receive the purchases and recommendations JSON
    var purchasesList = [PurchaseListObject]()

    //
    // MARK: - main loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPurchases()

    }

    //
    // MARK: - Call the Recommendation API to pull off the JSON with purchases and recommendations
    func getPurchases() {
        
        
        // Check whether the demo experience is secure or unsecure
        if (self.defaults.bool(forKey: Common.Demo.demoExperienceDefaultsKey)) {
            
            print("Secure Demo Experience")
            
            let access_token = defaults.string(forKey: "access_token")!
            print ("Access token used: \(access_token)")
            
            // Secure Experience - using access_token
            let urlRequest = Common.Demo.demoAPICustomerPurchasesBeforeCustomerNumber + customerNumber + Common.Demo.demoAPICustomerPurchasesAfterCustomerNumber+"?access_token=\(access_token)"
            
            print ("URL------> \(urlRequest)")
            
            // Uses third party Alamofire framework to make the API Call
            Alamofire.request(urlRequest, method: .get).validate().responseJSON { response in
                
                switch response.result {
                    
                case .success(let value):
                    
                    let json = JSON(value)
                    print("Purchases JSON: \(json)")
                    print("Starting the loop...")
                    
                    var count = 0
                    for (key,subJson):(String, JSON) in json {
                        self.purchasesList.append(PurchaseListObject(pItem: key, pRec: subJson.rawValue as! [String]))
                        count += 1
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                // Force the tableView to reload and use the new purchaseList dictionary
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
                self.tableView.reloadData()
                
            }
            
        } else {
            
            // Unsecure Experience - no access_token
            let urlRequest = Common.Demo.demoAPICustomerPurchasesBeforeCustomerNumber + customerNumber + Common.Demo.demoAPICustomerPurchasesAfterCustomerNumber
            
            // Uses third party Alamofire framework to make the API Call
            Alamofire.request(urlRequest, method: .get).validate().responseJSON { response in
                
                switch response.result {
                    
                case .success(let value):
                    
                    let json = JSON(value)
                    print("Purchases JSON: \(json)")
                    print("Starting the loop...")
                    
                    var count = 0
                    for (key,subJson):(String, JSON) in json {
                        self.purchasesList.append(PurchaseListObject(pItem: key, pRec: subJson.rawValue as! [String]))
                        count += 1
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                // Force the tableView to reload and use the new purchaseList dictionary
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
                self.tableView.reloadData()
                
            }
        }

        
        
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.purchasesList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.purchasesList[section].recommendations.count
    }

    // Section of the table = purchased item name
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.purchasesList[section].item
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecommendationsTableViewCell
        let image : UIImage = UIImage(named: Common.Demo.demoRecommendationImage)!
        
        cell.lblCell.text = self.purchasesList[indexPath.section].recommendations[indexPath.row]
        cell.imgCell.image = image
    
        return cell
    }

    // Format the Section Header (Purchased Item Name)
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        // Font color
        header.textLabel?.textColor = UIColor.black
        // Font size
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        header.backgroundColor = UIColor.darkGray
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
