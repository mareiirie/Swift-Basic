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
                    
                    for forecast in forecast {
                        addForecast(forecast: forecast)
                    }
                    //descriptionをラベルに貼りつけ
                    self.descriptionLabel.text = descript
                } catch {
                    print(error)
                }
        }
        
        //引数ありのファンクションを作成、「自分で作成したテーブル「Infos」の変数名：引数名」
        func addForecast(forecast: Forecast){
            do{
                let realm = try Realm()
                try realm.write({ () -> Void in
                    let addinfos = [Infos(value: ["date1": forecast.date,"telop1": forecast.telop, "url1": forecast.image.url])]
                    realm.add(addinfos)
                    print("addinfosの一つは\(forecast.date)")
                    print("Saved")
                    print(Realm.Configuration.defaultConfiguration.fileURL!)
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
