//
//  ViewController.swift
//  2-1-17
//
//  Created by 入江真礼 on 2019/10/09.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func next(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ViewController2", bundle: nil)
        let second = storyboard.instantiateInitialViewController()
        self.present(second!, animated: true, completion: nil)
    }
    
    // Segue 準備
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
