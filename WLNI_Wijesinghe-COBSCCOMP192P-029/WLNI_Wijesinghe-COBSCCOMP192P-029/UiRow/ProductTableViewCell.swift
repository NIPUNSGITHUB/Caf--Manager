//
//  ProductTableViewCell.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/27/21.
//

import UIKit
import Firebase
class ProductTableViewCell: UITableViewCell {
    private let db = Database.database().reference();
    var id = "";
    @IBOutlet weak var uiDiscount: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var switchSell: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        uiDiscount.layer.cornerRadius = 10.0;
        imgProduct.layer.borderWidth = 1
        imgProduct.layer.masksToBounds = false
        imgProduct.layer.borderColor = UIColor.black.cgColor
        imgProduct.layer.cornerRadius = imgProduct.frame.height/2
        imgProduct.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(pro:Product) {
        self.lblProductName.text=pro.name
        self.lblProductDesc.text=pro.description
        self.lblPrice.text = pro.price
        
        var aaa = "https://firebasestorage.googleapis.com/v0/b/iosass-98c3a.appspot.com/o" + pro.image +
        "?alt=media&token=90784910-d017-4a15-b164-af4f55e31a49";
        
        
        let url = URL( string: aaa)
        let data = try? Data(contentsOf: url!)
        self.imgProduct.image = UIImage(data: data!)
        if pro.discount == "0" {
            self.uiDiscount.isHidden = true
        }
        else
        {
            self.lblDiscount.text=pro.discount
        }
        
        self.lblCategory.text = pro.category
        self.id = pro.id
        pro.asSell != 0 ? self.switchSell.setOn(true, animated: true) : self.switchSell.setOn(false, animated: true);
      
      }

    @IBAction func asSellSwitchClick(_ sender: Any) {
         
        self.db.child("Product").child(id).child("sellAsItem").setValue(switchSell.isOn ? 1 : 0);
      
    }
    
}

