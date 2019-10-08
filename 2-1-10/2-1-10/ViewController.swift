//
//  ViewController.swift
//  2-1-10
//
//  Created by 入江真礼 on 2019/10/03.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //多次元配列の初期化
    var plistArr = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "PropertyList", ofType: "plist")
        
        //参照したplistを、初期化した配列に納入
        plistArr = NSArray(contentsOfFile: path!) as! [Dictionary<String, String>]
        
        
    }
    
    //行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mathArr.count
    }
    
    
    //表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "[任意]cell", for: indexPath) as![任意];cell
        
        cell.textLabel?.text = plistArr[indexPath.row]["title"]
        return cell
    }
    
    //タップ時の処理（例：任意のURLをWebViewControllerで表示）
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tappedCellUrl = plistArr[indexPath.row]["url"]!
        performSegue(withIdentifier: "toWebViewController", sender: nil)
        
    }


}

