//
//  ViewController.swift
//  2-1-11
//
//  Created by 入江真礼 on 2019/10/08.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let sectionTitle = ["主人公", "パッショーネのメンバー", "ハンターチーム"]

//items初期化　()の意味はなに？？？
    var items = [[[String: String]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "PropertyList", ofType:"plist")
        items = NSArray(contentsOfFile:path!)as! [[[String: String]]]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
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
    return self.items[section].count
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
            
            cell.imageCell.image = UIImage(named: items[0][indexPath.row]["name"]!)
            cell.labelCell.text = String(items[0][indexPath.row]["name"]!)
            
        }
        else if indexPath.section == 1 {
            print("indexPath.section == 1")
            cell.imageCell.image = UIImage(named: items[1][indexPath.row]["name"]!)
            cell.labelCell.text = String(items[1][indexPath.row]["name"]!)
            
        }
        else if indexPath.section == 2 {
            print("indexPath.section == 2")
            cell.imageCell.image = UIImage(named: items[2][indexPath.row]["name"]!)
            cell.labelCell.text = String(items[2][indexPath.row]["name"]!)
        }
        
        return cell
    }

}

