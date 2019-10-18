//
//  ViewController.swift
//  2-1-11
//
//  Created by 入江真礼 on 2019/10/08.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {



    // section毎の画像配列
    let imgArray1: NSArray = ["ジョジョ"]
    let imgArray2: NSArray = ["ナランチャ","ブチャラティ","ミスタ"]
    let imgArray3: NSArray = ["リゾット"]
    
 //   let labelArray1: NSArray = ["ジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナジョルノジョバーナ"]
 //   let labelArray2: NSArray = ["ミスタ","ブチャラティ","ナランチャ"]
 //   let labelArray3: NSArray = ["リゾット"]
    
    let sectionTitle: NSArray = [
        "主人公",
        "パッショーネのメンバー",
        "ハンターチーム"]

//items初期化　()の意味はなに？？？
    var items = [Array<Dictionary<String,String>>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "PropertyList", ofType:"plist")
        items = NSArray(contentsOfFile:path!)as! [Array<Dictionary<String,String>>]
            }

// Section数
   override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
// Sectioのタイトル
   override func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
// Table Viewのセルの数（row）を指定
   override func tableView(_ table: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items[0].count
        }
        else if section == 1 {
            return items[1].count
        }
        else if section == 2 {
            return items[2].count
        }
        else{
            return 0
        }
    }
    
//各セルの要素を設定する
    override func tableView(_ table: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "CustomCell",
                                             for: indexPath) as! CustomCell

// Section毎に処理を分ける
        if indexPath.section == 0 {
            print("indexPath.section == 0")
            
            cell.imageCell.image = UIImage(named:imgArray1[indexPath.row] as! String)
            cell.labelCell.text = String(items[0][indexPath.row]["name"]!)
            
        }
        else if indexPath.section == 1 {
            print("indexPath.section == 1")
            cell.imageCell.image = UIImage(named:imgArray2[indexPath.row] as! String)
            cell.labelCell.text = String(items[1][indexPath.row]["name"]!)
            
        }
        else if indexPath.section == 2 {
            print("indexPath.section == 2")
            cell.imageCell.image = UIImage(named:imgArray3[indexPath.row] as! String)
            cell.labelCell.text = String(items[2][indexPath.row]["name"]!)
        }
        
        return cell
    }
    
   override func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 60
    return UITableView.automaticDimension

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}

