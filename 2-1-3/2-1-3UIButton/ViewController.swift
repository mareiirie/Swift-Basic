//
//  ViewController.swift
//  2-1-3UIButton
//
//  Created by 入江真礼 on 2019/10/01.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var img1 = UIImage(named:"UNADJUSTEDNONRAW_thumb_1ef")!
    var img2 = UIImage(named:"UNADJUSTEDNONRAW_thumb_1f0")!
    var img3 = UIImage(named:"UNADJUSTEDNONRAW_thumb_1f1")!
    var img4 = UIImage(named:"UNADJUSTEDNONRAW_thumb_1f2")!
    var img5 = UIImage(named:"UNADJUSTEDNONRAW_thumb_1f3")!

    
    
    @IBOutlet weak var image1: UIImageView!

    
    @IBAction func button1(_ sender: Any) {
        let random = arc4random() % 10
        print(random)
        if ( random > 8 ) {
            image1.image = img1
        } else if ( random > 6) {
            image1.image = img2
        } else if ( random > 4) {
            image1.image = img3
        } else if ( random > 2) {
            image1.image = img4
        } else {
            image1.image = img5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

