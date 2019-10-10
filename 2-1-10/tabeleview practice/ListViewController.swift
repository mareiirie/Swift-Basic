//
//  File.swift
//  tabeleview practice
//
//  Created by 入江真礼 on 2019/10/07.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    //itemsはArray型です
    var _items:NSArray = []
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
                // pathは、Plistからとってきています
        let path = Bundle.main.path(forResource: "PropertyList", ofType:"plist")
        //itemsは、plistからとってきたpathのうち、arrayです
        _items = NSArray(contentsOfFile:path!)!
    }
    
    //プロトコルの必須メソッド
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    //プロトコルの必須メソッド
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                     for: indexPath)
            //dicは、itemsのうち、row番目のインスタンスです
            let dic = _items.object(at: indexPath.row) as!NSDictionary
            
            //タグ付けで、ストーリーボードと紐付け
            let imageView = cell.viewWithTag(1) as! UIImageView
            let label1 = cell.viewWithTag(2) as! UILabel
            let label2 = cell.viewWithTag(3) as! UILabel
            
            //plistのitemsから、forkeyに該当するものを定義
            label1.text = dic.value(forKey: "name") as? String
            label2.text = dic.value(forKey: "note") as? String
            
    //plistにはStringデータとして入っているので、まずはStringデータを抜き出し、imgNameに定義
            let imgName = dic.value(forKey: "image") as! String
            //imgNameという名前のUIImageを、imgとして再定義
            let img = UIImage(named: imgName)
            
            //イメージviewへ定数imgを反映
            imageView.image = img
            
            return cell
    }

}
