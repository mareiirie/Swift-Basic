//
//  ViewController.swift
//  2-1-5
//
//  Created by 入江真礼 on 2019/10/03.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: UIAlertController.Style.actionSheet)
        
        
        let facebookAction = UIAlertAction(title: "Facebook",
                                    style: UIAlertAction.Style.default,
                                    handler: {
            (action: UIAlertAction!) in
            print("Facebook")
        })
        
        let twitterAction = UIAlertAction(title: "Twitter",
                                    style: UIAlertAction.Style.default,
                                    handler: { _ in
            print("Twitter")
        })
        
        let lineAction = UIAlertAction(title: "LINE",
                                    style: UIAlertAction.Style.destructive,
                                    handler: { _ in
            print("LINE")
        })
        
        let cancel = UIAlertAction(title: "キャンセル",
                                   style: UIAlertAction.Style.cancel,
                                   handler: { _ in
            print("キャンセルをタップした時の処理")
        })
        
        
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(twitterAction)
        actionSheet.addAction(lineAction)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
}
