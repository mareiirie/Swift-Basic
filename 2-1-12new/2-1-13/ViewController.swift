//
//  ViewController.swift
//  2-1-13
//
//  Created by 入江真礼 on 2019/10/08.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
let photos = ["ジョルノジョバーナ", "ミスタ", "ナランチャ", "ブチャラティ", "ディオ", "ポルナレフ", "花京院", "承太郎", "吉良吉影"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")

    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // "Cell" はストーリーボードで設定したセルのID
        let testCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell",
                                               for: indexPath) as! CustomCell
        
        testCell.imgView.image = UIImage(named: photos[indexPath.row])
        testCell.lblView.text = photos[indexPath.row]
        
        // Tag番号を使ってImageViewのインスタンス生成c
//        let imageView = testCell as! UIImageView
//        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
//        let cellImage = UIImage(named: photos[indexPath.row])
//        // UIImageをUIImageViewのimageとして設定
//        imageView.image = cellImage

        
//        // Tag番号を使ってLabelのインスタンス生成
//        let label = testCell.contentView.viewWithTag(2) as! UILabel
//        label.text = photos[indexPath.row]
        
        return testCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return photos.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



