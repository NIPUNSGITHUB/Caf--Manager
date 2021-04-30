//
//  PrintOrderTableViewCell.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/30/21.
//

import UIKit

class PrintOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCustName: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblitem: UILabel!
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
        self.lblitem.text = ord.itemJson;
    }
    
    
    @IBAction func btnPrint(_ sender: Any) {
        var markuptext=""
         
        markuptext += "<tr> <td> \(String(order.customerName)) </td> <td> \(String(order.id)) </td> <td> \(String(order.total)) </td> </tr>"
                    
          
            
            var temp="<center><table><tr><th>Unit</th><th>Name</th><th>Price</th></tr>\(markuptext)</table></center>"
          
     }
}
