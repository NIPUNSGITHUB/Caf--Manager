//
//  CategoryTableViewCell.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/24/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var txt_category:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(cat:Category) {
        self.txt_category.text=cat.name
    }
    
}
