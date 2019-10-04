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
        
        let action1 = UIAlertAction(title: "Facebook",
                                    style: UIAlertAction.Style.default,
                                    handler: {
            (action: UIAlertAction!) in
            print("Facebook")
        })
        
        let action2 = UIAlertAction(title: "Twitter",
                                    style: UIAlertAction.Style.default,
                                    handler: {
            (action: UIAlertAction!) in
            print("Twitter")
        })
        
        let action3 = UIAlertAction(title: "LINE",
                                    style: UIAlertAction.Style.destructive,
                                    handler: {
            (action: UIAlertAction!) in
            print("LINE")
        })
        
        let cancel = UIAlertAction(title: "キャンセル",
                                   style: UIAlertAction.Style.cancel,
                                   handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}
