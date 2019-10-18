//
//  CustomCell.swift
//  2-1-11
//
//  Created by 入江真礼 on 2019/10/17.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
