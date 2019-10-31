//
//  Customcell.swift
//  2-4-2
//
//  Created by 入江真礼 on 2019/10/17.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit
import Alamofire
import RealmSwift

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlView: UIImageView!
    @IBOutlet weak var telopView: UILabel!
    @IBOutlet weak var dateView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
