//
//  ViewController.swift
//  2-4-2
//
//  Created by 入江真礼 on 2019/10/25.
//  Copyright © 2019 入江真礼. All rights reserved.
//
//conrollerから処理を任されるModel。

import UIKit
import Alamofire
import RealmSwift

protocol UseInfosDelegate {
    func setData(descript: String, infosLists: Array<Infos>)
}

class UseInfos {
    
    //    var infosList: Results<Infos>
    var infosLists: Array<Infos> = []
    var useinfosdelegate: UseInfosDelegate?
    var descript: String = ""
    
    func saveData() {
    let weatherurl = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
        Alamofire.request(weatherurl,
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
//infoという構造体の中の、forecastsという配列を取りしforecast(単数形にした),infoの中のdescriptionというStringを取り出す
                    let forecast = info.forecasts
                    let desc = info.description
                    self.descript = desc.text

//配列forecastsからう要素を取り出す。forecasts配列の要素はJSONデータを確認する
                    for forecast in forecast {
                        self.addForecast(forecast: forecast)
                    }
                } catch {
                    print(error)
                }
           }
        do{
            let realm = try Realm()
            infosLists = Array(realm.objects(Infos.self))
            print("saveData完了")
        }catch{
            fatalError("saveData失敗")
        }

    }

    func addForecast(forecast: Forecast){
        do{
           let realm = try Realm()
           try realm.write({ () -> Void in
                            let addinfos = [Infos(value: ["date1": forecast.date,"telop1": forecast.telop, "url1": forecast.image.url])]
                             realm.add(addinfos)
            useinfosdelegate?.setData(descript: descript, infosLists: infosLists)
            print("addinfosの一つは\(forecast.date)")
            print("Saved")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
                           })
          }catch{
                print("Save is Faild")
                }
    }

}
