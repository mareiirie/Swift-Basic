//
//  ViewController2.swift
//  2-1-17
//
//  Created by 入江真礼 on 2019/10/09.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit

class ViewController2: UIViewController {
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func back(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let first = storyboard.instantiateViewController(withIdentifier: "first")
        self.dismiss(animated: true, completion: nil)
    }

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
