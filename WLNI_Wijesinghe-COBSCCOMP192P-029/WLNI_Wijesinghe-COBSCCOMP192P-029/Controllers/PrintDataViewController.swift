//
//  PrintDataViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/30/21.
//

import UIKit
import Firebase
class PrintDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let db = Database.database().reference()
    @IBOutlet weak var tblPrintList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblPrintList.delegate = self
        tblPrintList.dataSource = self
        
        let nib = UINib(nibName: "PrintOrderTableViewCell", bundle: nil)
        tblPrintList.register(nib, forCellReuseIdentifier: "printListItem")
        
        lodaData();
    }
    var order = Order();
    var orderArr:[Order] = [];
    
    
    @objc func lodaData(){

         let group = DispatchGroup()
                 self.db.child("Orders").getData { (error, snapshot) in
                      if snapshot.exists() {

                        let dataChange = snapshot.value as! [String:AnyObject]

                        group.wait()
                        self.orderArr.removeAll()
                         dataChange.forEach({ (key,val) in

                            let objOrder = Order(
                                id: key as! String,
                                customerName:val["customerName"] as! String,
                                orderedLocation:val["orderedLocation"] as! String,
                                address:val["address"] as! String,
                                contactNo:val["contactNo"] as! String,
                                itemJson:val["itemJson"] as! String,
                                total:val["total"] as! String,
                                orderCreatedAt:val["orderCreatedAt"] as! String,
                                status:val["status"] as! Int
                            );
                             self.orderArr.append(objOrder)

                         })



                         group.notify(queue: .main) {
                                 // do something here when loop finished
                            self.orderArr.sorted() { $0.id > $1.id }
                            self.tblPrintList.reloadData()
                           
                         }
                        // print("Got data",snapshot.value!)
                     }
                 }
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.orderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell=tableView.dequeueReusableCell(withIdentifier: "printListItem", for: indexPath) as! PrintOrderTableViewCell
        cell.setupView(ord: orderArr[indexPath.row])
        return cell
       
    }
 
}
