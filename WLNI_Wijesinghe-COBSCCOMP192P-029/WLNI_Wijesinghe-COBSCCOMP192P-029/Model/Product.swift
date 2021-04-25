//
//  Product.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/25/21.
//

import Foundation
struct Product {
    var id:String!
    var name:String!
    var description:String!
    var price:String!
    var discount:String!
    var asSell:String!
    func getJSON() -> NSMutableDictionary {
           let dict = NSMutableDictionary()
            dict.setValue(id, forKey: "id")
            dict.setValue(name, forKey: "name")
            dict.setValue(description, forKey: "description")
            dict.setValue(price, forKey: "price")
            dict.setValue(discount, forKey: "discount")
            dict.setValue(asSell, forKey: "asSell")
           return dict
    }
}
