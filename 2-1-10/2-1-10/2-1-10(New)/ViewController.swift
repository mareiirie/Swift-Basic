//
//  ViewController.swift
//  2-1-10(New)
//
//  Created by 入江真礼 on 2019/10/12.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    var items = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.dataSource = self
        
        // Identifierを設定
        tbl.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        tbl.estimatedRowHeight = 50
        tbl.rowHeight = UITableView.automaticDimension
        // pathは、Plistからとってきています
        guard let path = Bundle.main.path(forResource: "PropertyList", ofType:"plist") else{
            fatalError("plisterror")
        }
        //itemsは、plistからとってきたpathのうち、arrayです
        items = NSArray(contentsOfFile:path)as! [[String:String]]
        
    }
    
    //numberofrowinsectionの数は、dicの数にしたい
    
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! JojoInfoCell
        
        guard let imgName = items[indexPath.row]["name"] else {
            fatalError("imgNameerror")
        }
        cell.nameLabel.text = items[indexPath.row]["name"]
        cell.noteLabel.text = items[indexPath.row]["note"]
        cell.img.image = UIImage(named: imgName)
        
        return cell
    }
    
    
}
