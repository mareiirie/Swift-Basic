//
//  FavoriteProgrammingLanguage.swift
//  1-1-5
//
//  Created by 入江真礼 on 2019/10/27.
//  Copyright © 2019 入江真礼. All rights reserved.
//
//joinでデリゲートメソッドを実行、実行を任せるメソッド

import Foundation

class FavoriteProgrammingLanguage {
    var delegate: FavoriteProgrammingLanguageDelegate?
    func join() {
        print("インターンに参加します")
        if let delegate = self.delegate{
            delegate.canSwift()
        }else{
            print("何もしません")
        }
    }
}

