//
//  ViewController.swift
//  2-6-2
//
//  Created by 入江真礼 on 2019/10/24.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
        // Do any additional setup after loading the view.
    }
    
    func labelshow (hosturl : String) {
        label.text = hosturl
    }


}

