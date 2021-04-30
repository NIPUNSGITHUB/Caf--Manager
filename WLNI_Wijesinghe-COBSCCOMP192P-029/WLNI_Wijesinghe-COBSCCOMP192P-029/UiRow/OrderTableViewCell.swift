//
//  OrderTableViewCell.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/30/21.
//

import UIKit
import Firebase
class OrderTableViewCell: UITableViewCell {
    private let db = Database.database().reference()
    weak var orderViewController : OrderViewController?
    @IBOutlet weak var lblCustName: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnRejectOrder: UIButton!
    @IBOutlet weak var btnAcceptOrder: UIButton!
    @IBOutlet weak var btnAwaitingOrder: UIButton!
    var order = Order();
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(ord:Order) {
        order = ord;
        self.lblCustName.text = ord.customerName;
        self.lblOrderId.text = ord.id;
        if ord.status == 1 {
            self.btnStatus.isHidden = false
            self.btnRejectOrder.isHidden = false;
            self.btnAcceptOrder.isHidden = false;
            self.btnAwaitingOrder.isHidden = true

        }
        else
        {
            
            self.btnStatus.isHidden = true
            self.btnAwaitingOrder.isHidden = false
            self.btnRejectOrder.isHidden = true;
            self.btnAcceptOrder.isHidden = true;
        }
       
    }
    
    @IBAction func btnReject(_ sender: Any) {
        let group = DispatchGroup()
        self.db.child("Orders").child(order.id).child("status").setValue(0);
        group.wait()
    
        group.notify(queue: .main) {
            self.orderViewController?.lodaData();
           
        }
        
    }
    
    @IBAction func btnAccept(_ sender: Any) {
        
        let group = DispatchGroup()
        self.db.child("Orders").child(order.id).child("status").setValue(1);
        group.wait()
    
        group.notify(queue: .main) {
            self.orderViewController?.lodaData();
        }
        
    }
    
    @IBAction func btnInfo(_ sender: Any) {
       orderViewController?.showSimpleActionSheet(ord:order)
    }
    
    
    //
    
   
}
