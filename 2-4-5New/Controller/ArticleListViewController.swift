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

class ArticleListViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    //InfosをオブジェクトにもつArrayが、このクラスのどこでも使えるように（主にtableviewの中で使うため）変数を初期値で宣言しておく。
    //後は、デリゲートでModelがとってきたデータをsetDataが受け取り、このクラスで定義しているinfoListに、ModelのinfosListsを代入する。
    //このクラスのinfoListに値が入ったので、tableviewをリロードしてあげれば読み込まれる。
    var infoList: [Infos] = []
    var descripttext = ""
    let sectionTitle = ["天気情報","概要"]
    enum Section: Int {
        case CustomCell
        case DescriptionCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let useinfos = UseInfos()
        useinfos.useinfosdelegate = self
        useinfos.saveData()
        print("savedataメソッドを使う")
        print("Modelから通知を受けたのでsetDataメソッドを使う")
        tableview.dataSource = self
        tableview.estimatedRowHeight = 60
        tableview.rowHeight = UITableView.automaticDimension
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

extension ArticleListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("セクション数は\(sectionTitle.count)です")
        return sectionTitle.count
    }
    
    //enum を使用
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        switch Section(rawValue: section) {
        case .some(.CustomCell):
            return infoList.count
        case .some(.DescriptionCell):
            return 1
        case .none:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let enumSection = Section(rawValue: indexPath.section)
        switch enumSection {
        case .some(.CustomCell):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? ArticleCell {
                let object = infoList[indexPath.row]
                print("tableviewcellの処理を行う")
                cell.dateView.text = object.date
                cell.telopView.text = object.telop
                print("dateに入るのは\(String(describing: object.date))")
                let imageView = cell.urlView as UIImageView
                imageView.setImage(fromUrl: object.url)
                print("tableviewcellにデータを代入しました")
                return cell
            }
            
        case .some(.DescriptionCell):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? ArticleCell {
                cell.descriptionLabel.text = descripttext
                print("descriptは\(descripttext)です")
                return cell
            }
            
        default :
            print("Section error")
        }
        return UITableViewCell()
    }
    
}

extension ArticleListViewController: UseInfosDelegate {
    
    func setData(descript: String, infosLists: Array<Infos>) {
        descripttext = descript
        print("decsriptをもらったので代入します")
        infoList = infosLists
        print("infoListsをもらったので、infoListに代入します")
        tableview.reloadData()
    }
    //alertで出す
    func error(descript: String) {
        let alert: UIAlertController = UIAlertController(title: "エラー",
                                                         message: descript, preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK",
                                                         style: UIAlertAction.Style.default,
                                                         handler:{
                                                            (action: UIAlertAction!) -> Void in
                                                            print("OK")
        })
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
