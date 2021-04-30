//
//  ItemListViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/27/21.
//

import UIKit
import Firebase
class ItemListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    private let db = Database.database().reference()
    @IBOutlet weak var tblProductList: UITableView!
   
    var ct:[Category] = []
    var pro:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblProductList.delegate = self
        tblProductList.dataSource = self
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tblProductList.register(nib, forCellReuseIdentifier: "foodListItem")
        lodaData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnProductLoad(_ sender: Any) {
        lodaData()
    }
    
    @objc func lodaData(){
         
         let group = DispatchGroup()
                 self.db.child("Product").getData { (error, snapshot) in
                      if snapshot.exists() {
                         
                         let dataChange = snapshot.value as! [String:AnyObject]
                        
                         group.wait()
                        self.pro.removeAll()
                         dataChange.forEach({ (key,val) in
                           
                            let objProduct = Product(
                                id: key as! String,
                                name: val["name"] as! String,
                                description: val["description"]as! String,
                                price: val["price"]as! String,
                                discount: val["discount"]as! String,
                                image:val["image"]as! String,
                                category:val["category"]as! String,
                                asSell: val["sellAsItem"] as! Int
                            );
                            
                            
                             self.pro.append(objProduct)
                           
                         })
                         
                       
                         
                         group.notify(queue: .main) {
                                 // do something here when loop finished
                            self.pro.sorted() { $0.name > $1.name }
                            self.tblProductList.reloadData()
                         }
                        // print("Got data",snapshot.value!)
                     }
                 }
     }
    
    
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pro.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "foodListItem", for: indexPath) as! ProductTableViewCell
      
            cell.setupView(pro: pro[indexPath.row])
        
            return cell
        
     }
     
}
