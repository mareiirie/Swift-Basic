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

class ArticleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var infosList: Results<Infos>!
    private let wurl = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        Alamofire.request(wurl,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .response { response in
                guard let data = response.data else {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let info: WeatherNews = try decoder.decode(WeatherNews.self, from: data)
                    print(info)
                    //infoという構造体の中の、forecastsという配列を取り出しforecast(単数形にした)と定義
                    //infoの中のdescriptionというStringを取り出す
                    let forecast = info.forecasts
                    let desc = info.description
                    let descript = desc.text
                    //配列forecastsからう要素を取り出す。forecasts配列の要素はJSONデータを確認する
                    let info0 = forecast[0]
                    let info1 = forecast[1]
                    let info2 = forecast[2]
                    
                    let date0 = info0.date
                    let telop0 = info0.telop
                    let url0 = info0.image.url
                    
                    let date1 = info1.date
                    let telop1 = info1.telop
                    let url1 = info1.image.url
                    
                    let date2 = info2.date
                    let telop2 = info2.telop
                    let url2 = info2.image.url
                    
                    //descriptionをラベルに貼りつけ
                    self.descriptionLabel.text = descript
                    
                    //APIで取得した上記のStringを引数に代入し、ファンクション起動
                    realmadd(d0: date0, t0: telop0, u0: url0, d1: date1, t1: telop1, u1: url1, d2: date2, t2: telop2, u2: url2)
                    
                 //   realmadd(d0: date0, t0: telop0, u0: url0, d1: date1, t1: telop1, u1: url1)
                    
                } catch {
                    print(error)
                }
        }
        
        //引数ありのファンクションを作成、「自分で作成したテーブル「Infos」の変数名：引数名」
        func realmadd(d0: String, t0: String, u0: String, d1: String, t1: String, u1: String, d2: String, t2: String,u2 :String) {
        //func realmadd(d0: String, t0: String, u0: String, d1: String, t1: String, u1: String) {
            do{
                let realm = try Realm()
                try realm.write({ () -> Void in
                    let addinfos = [Infos(value: ["date1": d0, "telop1": t0, "url1": u0]),
                                    Infos(value: ["date1": d1, "telop1": t1, "url1": u1]),
                                    Infos(value: ["date1": d2, "telop1": t2, "url1": u2])]
                    
                    realm.add(addinfos)
                    print("Saved")
                })
            }catch{
                print("Save is Faild")
            }
            
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

    // 永続化されているデータを取りだす
    do{
    let realm = try Realm()
    infosList = realm.objects(Infos.self)
  //  tableView.reloadData()
    }catch{
    
    }
    
    }
    
//override func viewWillAppear(_ animated: Bool) {
 //   super.viewWillAppear(animated)
 //   tableView.reloadData()}
    

    

    

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
    return infosList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell {
        let object = infosList[indexPath.row]
        
        cell.dateView.text = object.date1
        cell.telopView.text = object.telop1
      
        let imageView = cell.urlView as! UIImageView
        imageView.setImage(fromUrl: object.url1)
        
        return cell
    }
    return UITableViewCell()
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
