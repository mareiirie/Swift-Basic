//
//  ViewController.swift
//  2-1-10(New)
//
//  Created by 入江真礼 on 2019/10/12.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl: UITableView!
    var items = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.delegate = self
        self.tbl.dataSource = self
        
        // Identifierを設定
        self.tbl.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        tbl.estimatedRowHeight = 50
        tbl.rowHeight = UITableView.automaticDimension
        // pathは、Plistからとってきています
        let path = Bundle.main.path(forResource: "PropertyList", ofType:"plist")
        //itemsは、plistからとってきたpathのうち、arrayです
        items = NSArray(contentsOfFile:path!)as! [[String:String]]
        
    }
    
    //numberofrowinsectionの数は、dicの数にしたい
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! JojoInfoCell
        
        let imgName = items[indexPath.row]["name"]
        cell.label.text = items[indexPath.row]["name"]
        cell.label2.text = items[indexPath.row]["note"]
        cell.img.image = UIImage(named: imgName as! String)
        
        return cell
    }
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}



