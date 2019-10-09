//
//  ViewController.swift
//  2-1-18,19
//
//  Created by 入江真礼 on 2019/10/09.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func button(_ sender: Any) {

    //遷移先のインスタンス
        //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "next") as! ViewController2
        
        //ViewController2のtextにtextFieldのテキストを代入
        vc2.text = textField.text!
        
        //NavigationControllerを継承したViewControllerを遷移
        self.navigationController?.pushViewController(vc2, animated: true)
        
    }
    
}


