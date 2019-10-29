//
//  ArticleListViewController.swift
//  2-4-2
//
//  Created by 入江真礼 on 2019/10/14.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class ArticleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UseInfosDelegate{

    @IBOutlet weak var tableview: UITableView!

//InfosをオブジェクトにもつArrayが、このクラスのどこでも使えるように（主にtableviewの中で使うため）変数を初期値で宣言しておく。
//後は、デリゲートでModelがとってきたデータをsetDataが受け取り、このクラスで定義しているinfoListに、ModelのinfosListsを代入する。
//このクラスのinfoListに値が入ったので、tableviewをリロードしてあげれば読み込まれる。
    var infoList: Array<Infos> = []
    var descripttext = ""
    let sectionTitle: NSArray = ["天気情報","概要",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let useinfos = UseInfos()
        useinfos.saveData()
        print("savedataメソッドを使う")
        useinfos.useinfosdelegate = self
        print("Modelから通知を受けたのでsetDataメソッドを使う")
        tableview.delegate = self
        tableview.dataSource = self
        }

    func setData(descript: String, infosLists: Array<Infos>) {
        descripttext = descript
        print("decsriptをもらったので代入します")
        infoList = infosLists
        print("infoListsをもらったので、infoListに代入します")
        tableview.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("セクション数は\(sectionTitle.count)です")
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        if section == 0 {
            print("numberofrowsectionは\(infoList.count)")
            return infoList.count
        }else if section == 1 {
            return 1
        }else{
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case 0:
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell {
        let object = infoList[indexPath.row]
         print("tableviewcellの処理を行う")
        cell.dateView.text = object.date1
        cell.telopView.text = object.telop1
         print("dateに入るのは\(String(describing: object.date1))")
        let imageView = cell.urlView as UIImageView
        imageView.setImage(fromUrl: object.url1)
         print("tableviewcellにデータを代入しました")
        return cell
            }
            
        case 1:
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? CustomCell {
        cell.descriptionLabel.text = descripttext
            print("descriptは\(descripttext)です")
        return cell
            }
            
        default :
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell {
                let object = infoList[indexPath.row]
                cell.dateView.text = "default"
                }
        }
    return UITableViewCell()
    }
    
    func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableview.estimatedRowHeight = 60
        return UITableView.automaticDimension
        
    }

}


extension UIImageView {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func setImage(fromUrl: String?) {
        
        //URLがnilだった場合はdefaultの画像をセットする
        guard let urlString = fromUrl else {
            self.image = UIImage(named: "default")
            return
        }
        //キャッシュされているURLならば、その中から画像を取り出してセットする
        if let cacheImage = UIImageView.imageCache.object(forKey: fromUrl as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        let imageUrl = URL(string: urlString)
        DispatchQueue.global().async {
            do {
                //まだ一度も取得していない画像をURLから画像を取得し、キャッシュする
                let data = try Data(contentsOf: imageUrl!)
                let image = UIImage(data: data)
                UIImageView.imageCache.setObject(image!, forKey: fromUrl as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch let error {
                //エラーの場合にはdefaultの画像をセットする
                print("Error : \(error.localizedDescription)")
                self.image = UIImage(named: "default")
                
            }
        }
    }
}
