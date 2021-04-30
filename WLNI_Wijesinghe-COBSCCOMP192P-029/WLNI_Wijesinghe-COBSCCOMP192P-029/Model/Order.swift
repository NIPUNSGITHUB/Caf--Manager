//
//  Order.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/30/21.
//

import Foundation
import Firebase
struct  Order {
    private let db = Database.database().reference();
    var id:String!
    var customerName:String!
    var orderedLocation:String!
    var address:String!
    var contactNo:String!
    var itemJson:String!
    var total:String!
    var orderCreatedAt:String!
    var status:Int!
    let rId = UUID().uuidString
    func getJSON() -> NSMutableDictionary {
        let dict = NSMutableDictionary()
        dict.setValue(id, forKey: "id")
        dict.setValue(customerName, forKey: "customerName")
        dict.setValue(orderedLocation, forKey: "orderedLocation")
        dict.setValue(address, forKey: "address")
        dict.setValue(contactNo, forKey: "contactNo")
        dict.setValue(itemJson, forKey: "itemJson")
        dict.setValue(total, forKey: "total")
        dict.setValue(orderCreatedAt, forKey: "orderCreatedAt")
        dict.setValue(status, forKey: "status")
        return dict
    }
    
    
    let orderArray = [
        [
            "id":"2CDAED39-D6F0",
            "customerName":"H. W Perera",
            "orderedLocation":"6.917939811486741, 79.8860296817547",
            "address":"100/2 Borella North, Colombo",
            "contactNo":"07127372654",
            "itemJson":"[{\"itemId\": \"01658721-73DF-4FF4-BD11-AA4B763BAD84\",\"name\":\"Product1\",\"qty\":\"3\",\"unitPrice\":\"100.00\"}, {\"itemId\": \"D2CC8EF6-90DF-4CB8-8792-930EDC797CA1\",\"name\":\"Product1\",\"qty\":\"2\",\"unitPrice\":\"50.00\"} ]",
            "total":"200",
            "orderCreatedAt":"2021-04-31",
            "status":0
        ],
        [
            "id":"2F02D7E5-28C4",
            "customerName":"H. W Perera",
            "orderedLocation":"6.917939811486741, 79.8860296817547",
            "address":"100/2 Borella North, Colombo",
            "contactNo":"07127372654",
            "itemJson":"[{\"itemId\": \"01658721-73DF-4FF4-BD11-AA4B763BAD84\",\"name\":\"Product1\",\"qty\":\"3\",\"unitPrice\":\"100.00\"}, {\"itemId\": \"D2CC8EF6-90DF-4CB8-8792-930EDC797CA1\",\"name\":\"Product1\",\"qty\":\"2\",\"unitPrice\":\"50.00\"} ]",
            "total":"200",
            "orderCreatedAt":"2021-04-31",
            "status":1
        ],
        [
            "id":"2F48958D-F27C",
            "customerName":"H. W Perera",
            "orderedLocation":"6.917939811486741, 79.8860296817547",
            "address":"100/2 Borella North, Colombo",
            "contactNo":"07127372654",
            "itemJson":"[{\"itemId\": \"01658721-73DF-4FF4-BD11-AA4B763BAD84\",\"name\":\"Product1\",\"qty\":\"3\",\"unitPrice\":\"100.00\"}, {\"itemId\": \"D2CC8EF6-90DF-4CB8-8792-930EDC797CA1\",\"name\":\"Product1\",\"qty\":\"2\",\"unitPrice\":\"50.00\"} ]",
            "total":"200",
            "orderCreatedAt":"2021-04-31",
            "status":1
        ],
        [
            "id":"4543744D-F95E",
            "customerName":"H. W Perera",
            "orderedLocation":"6.917939811486741, 79.8860296817547",
            "address":"100/2 Borella North, Colombo",
            "contactNo":"07127372654",
            "itemJson":"[{\"itemId\": \"01658721-73DF-4FF4-BD11-AA4B763BAD84\",\"name\":\"Product1\",\"qty\":\"3\",\"unitPrice\":\"100.00\"}, {\"itemId\": \"D2CC8EF6-90DF-4CB8-8792-930EDC797CA1\",\"name\":\"Product1\",\"qty\":\"2\",\"unitPrice\":\"50.00\"} ]",
            "total":"200",
            "orderCreatedAt":"2021-04-31",
            "status":1
        ]
        
    ];
    
    func resetOrders()
    {
        
        for order in orderArray {
            self.db.child("Orders").child(order["id"]! as! String).setValue(order);
        }
        
        
    }
}
