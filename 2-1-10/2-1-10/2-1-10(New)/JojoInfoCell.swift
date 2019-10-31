//
//  CustomCell.swift
//  2-1-10(New)
//
//  Created by 入江真礼 on 2019/10/12.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class JojoInfoCell: UITableViewCell {

   //imageという変数名は使えなかった・・
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
