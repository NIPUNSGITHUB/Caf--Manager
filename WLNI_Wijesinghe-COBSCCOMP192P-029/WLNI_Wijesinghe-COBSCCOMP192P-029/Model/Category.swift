//
//  Category.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/24/21.
//

import Foundation
struct  Category {
        var name:String!
        var id:String!
        func getJSON() -> NSMutableDictionary {
               let dict = NSMutableDictionary()
               dict.setValue(name, forKey: "name")
                dict.setValue(id, forKey: "id")
               return dict
        }
}
