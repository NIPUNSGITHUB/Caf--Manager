//
//  ItemListViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/27/21.
//

import UIKit
import Firebase
class ItemListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var preview: UIButton!
    @IBOutlet weak var btnCategoryUi: UIButton!
    @IBOutlet weak var btnMenuUi: UIButton!
    private let db = Database.database().reference()
    @IBOutlet weak var tblProductList: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var loading: UIStackView!
    var ct:[Category] = []
    var pro:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblProductList.tableFooterView = UIView(frame: .zero)
        tblProductList.delegate = self
        tblProductList.dataSource = self
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tblProductList.register(nib, forCellReuseIdentifier: "foodListItem")
        preview.layer.cornerRadius = 10.0;
        btnCategoryUi.layer.cornerRadius = 10.0;
        btnMenuUi.layer.cornerRadius = 10.0;
        lodaData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnProductLoad(_ sender: Any) {
        lodaData()
    }
    
    @objc func lodaData(){
        spinner();
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
                            self.spinner()
                                 // do something here when loop finished
                            self.pro.sorted() { $0.name > $1.name }
                            self.tblProductList.reloadData()
                         }
                        // print("Got data",snapshot.value!)
                     }
                 }
     }
    
    func spinner() {
        activityLoader.color = UIColor.systemYellow;
        if tblProductList.isHidden {
            activityLoader.stopAnimating()
            loading.isHidden = true;
            tblProductList.isHidden = false;
        }
        else
        {
            loading.isHidden = false;
            activityLoader.startAnimating()
            tblProductList.isHidden = true;
        }

    }
    
    @IBAction func btnLogout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
           do {
             try firebaseAuth.signOut()
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = UIViewController()
                vc.modalPresentationStyle = .fullScreen
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "signinPage") as! SigninViewController
                self.present(nextViewController, animated:true, completion:nil)
           } catch let signOutError as NSError {
             print ("Error signing out: %@", signOutError)
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
