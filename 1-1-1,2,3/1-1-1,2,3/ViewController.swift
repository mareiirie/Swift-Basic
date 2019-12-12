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
        let name = "marei"
        print(name)
        
        let carSpeed = 75
        print(carSpeed)
        
        let isSpeedOver = carSpeed > 60
        
        if isSpeedOver{
            print("スピード違反")
        }
        
        let speed = 70.5
        print(speed)

//if else if文
        let score = 40
        
        var result : String
        
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
        let pokemons: [String] = ["ミュウツー","ピカチュウ","ポッポ"]
        print(pokemons[1])
        
        
    //dictionary
        let attack : [String: Int] = ["ミュウツー": 100, "ピカチュウ": 50]
        
        print(attack ["ミュウツー"] ?? "n.a.")

    }



}

