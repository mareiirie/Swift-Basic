//
//  ViewController2.swift
//  2-1-17
//
//  Created by 入江真礼 on 2019/10/09.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit

class ViewController2: UIViewController {
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier:"backSegue",sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
