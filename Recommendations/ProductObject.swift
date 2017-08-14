//
//  ProductObject.swift
//  Recommendations
//
//  Created by Alan Cota on 8/14/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import SwiftyJSON

class ProductObject {
    
    var productCode: String!
    var productName: String!
    
    required init (json: JSON) {
        
        productCode = json["productCode"].stringValue
        productName = json["productName"].stringValue
        
    }
    
}
