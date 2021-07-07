//
//  ArticleListViewController.swift
//  2-4-2
//
//  Created by 入江真礼 on 2019/10/14.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit
import Alamofire

class ArticleListViewController: UIViewController {
    
    private let wurl = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func showAlert(_ sender: Any) {

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
                    //配列forecastsからう要素を取り出す。forecasts配列の要素はJSONデータを確認する
                    let info0 = forecast[0]
                    let info1 = forecast[1]
                    let info2 = forecast[2]
                    
                    
                    let actionSheet = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: UIAlertController.Style.actionSheet)
                    
                    let action1 = UIAlertAction(title: "アクション１", style: UIAlertAction.Style.default, handler: {
                        (action: UIAlertAction!) in
                        print(info0)
                    })
                    
                    let action2 = UIAlertAction(title: "アクション２", style: UIAlertAction.Style.default, handler: {
                        (action: UIAlertAction!) in
                        print(info1)
                    })
                    
                    let action3 = UIAlertAction(title: "アクション３", style: UIAlertAction.Style.destructive, handler: {
                        (action: UIAlertAction!) in
                        print(info2)
                    })
                    
                    let cancel = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
                        (action: UIAlertAction!) in
                        print("キャンセル")
                    })
                    
                    actionSheet.addAction(action1)
                    actionSheet.addAction(action2)
                    actionSheet.addAction(action3)
                    actionSheet.addAction(cancel)
                    
                    self.present(actionSheet, animated: true, completion: nil)
                    
                } catch {
                    
                    print(error)
                    
                }
        }

    }
    
}


