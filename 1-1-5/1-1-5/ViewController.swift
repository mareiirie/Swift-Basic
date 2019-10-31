//
//  ViewController.swift
//  1-1-5
//
//  Created by 入江真礼 on 2019/10/27.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let favoriteprogramminglanguage = FavoriteProgrammingLanguage()
        let account = Account()
        
        //処理を任せるクラスの任せる先は、アカウントクラス
        favoriteprogramminglanguage.delegate = account
        
        //joinメソッドによってcanSwiftを呼び、canSwiftの中身の処理はAccountクラスに移譲済みのため、AccountクラスのcanSwiftが実行される。
        favoriteprogramminglanguage.join()
        // Do any additional setup after loading the view.
    }


}

