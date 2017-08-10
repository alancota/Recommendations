//
//  PurchaseListObject.swift
//  Recommendations
//
//  Created by Alan Cota on 8/10/17.
//  Copyright © 2017 CA Technologies. All rights reserved.
//

import Foundation

class PurchaseListObject {
    
    var item: String!
    var recommendations: [String]!
    
    required init (pItem: String, pRec: [String]) {
        item = pItem
        recommendations = pRec
    }
    
}
