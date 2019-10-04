//
//  ViewController.swift
//  1-1-1,2,3
//
//  Created by 入江真礼 on 2019/10/01.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//１−１−１
        //１−１−１
        var name : String = "marei"
        print(name)
        
        var carSpeed : Int = 75
        print(carSpeed)
        
        var isSpeedOver : Bool = carSpeed > 60
        
        if isSpeedOver{
            print("スピード違反")
        }
        
        var speed : Double = 70.5
        print(speed)

//if else if文
        var score = 40
        
        let result : String
        
        if score > 80 {
            
            result = "great"
            
        } else if score > 60 {
            
            result = "good"
            
        } else { result = "bad" }
        
        print(result)
        


//for文
        for number in 0...5 {
            
            print(number)
            
        }

        
   //switch文
        let pokemon : String = "ミュウツー"
        
        switch pokemon {
            
        case "ピカチュウ" :
            
            print("定番")
            
        case "ミュウツー" :
            
            print("めっちゃ強い")
            
        default:
            
            print("不明")
            
        }
    
    //array
        var Pokemon: [String] = ["ミュウツー","ピカチュウ","ポッポ"]
        print(Pokemon[1])
        
        
    //dictionary
        var attack : Dictionary<String, Int> = ["ミュウツー": 100, "ピカチュウ": 50]
        
        print(attack ["ミュウツー"] ?? "n.a.")

    }



}

