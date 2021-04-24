//
//  CategoryViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/24/21.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   

    private let db = Database.database().reference()
    var ct:[Category] = [
    ]
    @IBOutlet weak var txt_nmw: UITextField!
    @IBOutlet weak var tbl_category:UITableView!
    
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_category.delegate = self
        tbl_category.dataSource = self
        let nib=UINib(nibName: "CategoryTableViewCell", bundle: nil)
                tbl_category.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        lodaData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let cat = Category(name: txt_nmw.text)
        ct.append(cat)
        let child = UUID().uuidString
        self.db.child("Category").child(child).setValue(txt_nmw.text)
    }
    
    
    func refreshData(){
            refreshControl = UIRefreshControl()
                   refreshControl?.tintColor = UIColor.red
            refreshControl?.addTarget(self, action: #selector(lodaData), for: .valueChanged)
                   tbl_category.addSubview(refreshControl!)
           
        }
    
   @objc func lodaData(){
        
        let group = DispatchGroup()
                self.db.child("Category").getData { (error, snapshot) in
                     if snapshot.exists() {
                        
                        let dataChange = snapshot.value as! [String:AnyObject]
                      
                        
                      
                        group.wait()
                       
                        dataChange.forEach({ (key,val) in
                          
                            let cart = Category(name: val as! String,id: key as! String)
                            
                        
                            self.ct.append(cart)
                          
                        })
                        
                      
                        
                        group.notify(queue: .main) {
                                // do something here when loop finished
                            self.ct.sorted() { $0.name > $1.name }
                            self.tbl_category.reloadData()
                        }
                       // print("Got data",snapshot.value!)
                    }
                }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
             
                cell.setupView(cat: ct[indexPath.row])
            
                return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          
            if editingStyle == .delete {
               
                let id=ct[indexPath.row].id!
                self.db.child("Category").child(id).removeValue()
                ct.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .bottom)
               }
            
            
        }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
