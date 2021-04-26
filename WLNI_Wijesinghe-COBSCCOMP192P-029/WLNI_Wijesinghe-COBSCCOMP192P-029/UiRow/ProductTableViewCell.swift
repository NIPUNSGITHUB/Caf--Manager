//
//  ProductTableViewCell.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/27/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
  
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var switchSell: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
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
          //self.imgProduct.image = pro.image
          self.lblDiscount.text=pro.discount
      }

    
}
