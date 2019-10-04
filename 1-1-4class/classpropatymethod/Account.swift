//
//  ViewController2.swift
//  1-1-4
//
//  Created by 入江真礼 on 2019/10/04.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit


    class Account{
        var name : String
        var age : Int
        var sex : String
        var language : String
        
        init(name: String, age: Int, sex: String, language: String){
            self.name = name
            self.age = age
            self.sex = sex
            self.language = language
        }
        
        func person() {
            if sex == "男性"{
                print("\(name)君は\(language)が得意な\(age)歳です")
            } else {
                print("\(name)さんは\(language)が得意な\(age)歳です")
            }
            
        }
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


