//
//  ViewController.swift
//  2-5-7
//
//  Created by 入江真礼 on 2019/10/23.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MapViewを生成.
        let myMapView: MKMapView = MKMapView()
        myMapView.frame = self.view.frame
        
        // 経度、緯度.
        let myLatitude: CLLocationDegrees = 35.623655
        let myLongitude: CLLocationDegrees = 139.724858
        
        // 中心点.
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        
        // MapViewに中心点を設定.
        myMapView.setCenter(center, animated: true)
        
        // 縮尺.
        // 表示領域.
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
        
        // MapViewにregionを追加.
        myMapView.region = myRegion
        
        // viewにMapViewを追加.
        self.view.addSubview(myMapView)
        
        // ピンを生成.
        let myPin: MKPointAnnotation = MKPointAnnotation()
        
        // 座標を設定.
        myPin.coordinate = center
        
        // タイトルを設定.
        myPin.title = "株式会社スマートテック・ベンチャーズ"
        
        // サブタイトルを設定.
        myPin.subtitle = "今後急成長が期待される会社"
        
        // MapViewにピンを追加.
        myMapView.addAnnotation(myPin)
    }
    
}
