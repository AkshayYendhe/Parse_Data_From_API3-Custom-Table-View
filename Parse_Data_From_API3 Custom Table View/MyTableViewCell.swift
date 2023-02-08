//
//  MyTableViewCell.swift
//  Parse_Data_From_API3 Custom Table View
//
//  Created by Akshay Yendhe on 05/02/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var countrynameLabel: UILabel!
    
    @IBOutlet weak var capitalnameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
