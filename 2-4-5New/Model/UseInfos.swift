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
    func setData(descript: String, infosLists: [Infos])
    //失敗した時の処理を追加
    func error(descript: String)
}

class UseInfos {
    
    //    var infosList: Results<Infos>
    var infosLists: [Infos] = []
    var useinfosdelegate: UseInfosDelegate?
    var descript = ""
    
    func saveData() {
        let weatherurl = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
        Alamofire.request(weatherurl,
                          method: .get,
                          encoding: JSONEncoding.default
            )
            .response { response in
                guard let data = response.data else {
                    self.useinfosdelegate?.error(descript: "API取得失敗")
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
                    
                    //配列forecastsから要素を取り出す。forecasts配列の要素はJSONデータを確認する
                    for forecast in forecast {
                        let addforecasts = self.addForecast(forecast: forecast)
                        
                        //失敗した時はエラーデリゲート、if !~ は　if ~ == false と同義
                        if !addforecasts {
                            self.useinfosdelegate?.error(descript: "DB登録失敗")
                            return
                        } else {
                            
                        }
                        //returnは今のメソッドを中断するということ、デリゲートでcontrollerに失敗を通知
                        
                    }
                    let realm = try Realm()
                    self.infosLists = Array(realm.objects(Infos.self))
                    print("saveData完了")
                    self.useinfosdelegate?.setData(descript: self.descript, infosLists: self.infosLists)
                } catch {
                    self.useinfosdelegate?.error(descript: "DB取得失敗")
                }
        }
        
    }
    
    //BOOlをつけてtrueorfalseを返す
    func addForecast(forecast: Forecast) -> Bool {
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                let addinfos = [Infos(value: ["date": forecast.date,"telop": forecast.telop, "url": forecast.image.url])]
                realm.add(addinfos)
                print("addinfosの一つは\(forecast.date)")
                print("Saved")
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            })
            return true
        }catch{
            print("Save is Faild")
            return false
        }
    }
    
}
