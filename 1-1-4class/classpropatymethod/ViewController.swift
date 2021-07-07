//
//  ViewController.swift
//  クラスプロパティメソッド
//
//  Created by 入江真礼 on 2019/09/21.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let account = Account(name: "入江", age: 26, sex: "男性", language: "日本語")
        account.person()

        account.name = "入江🌟"
                account.age = 27
        //        account.sex = "男性"
        //        account.language = "日本語"
        account.person()

    }
}
