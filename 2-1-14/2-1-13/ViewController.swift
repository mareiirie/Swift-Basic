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

let photos1 = ["ジョルノジョバーナ", "ミスタ", "リゾット", "ナランチャ", "ブチャラティ"]
let photos2 = ["ディオ", "ポルナレフ", "花京院", "承太郎"]
let photos3 = ["吉良吉影"]
let sectionTitle = ["第５部登場人物","第３部登場人物","第４部登場人物"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // "cell" はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                               for: indexPath)
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
 //       let cellImage1 = UIImage(named: photos1[indexPath.row])
     //   let cellImage2 = UIImage(named: photos2[indexPath.row])
     //   let cellImage3 = UIImage(named: photos3[indexPath.row])
        //outofrangerエラーになったのは、indexPtahが、switch以下での最大値ではなく、条件分岐されてない状態で、インデックスとしての最大値が取られているため。（photo1とか２の区別はなく、インデックスの番号を単純にとってきてしまう）
        
        let label = testCell.contentView.viewWithTag(2) as! UILabel
        
        switch(indexPath.section){
        case 0:
            let cellImage1 = UIImage(named: photos1[indexPath.row])
            imageView.image = cellImage1
            label.text = photos1[indexPath.row]
        case 1:
            let cellImage2 = UIImage(named: photos2[indexPath.row])
            imageView.image = cellImage2
            label.text = photos2[indexPath.row]
        case 2:
            let cellImage3 = UIImage(named: photos3[indexPath.row])
            imageView.image = cellImage3
            label.text = photos3[indexPath.row]
        default:
            print("section error")
            
        }
        
        return testCell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は3つ
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        switch(section){
        case 0:
            return 5
        case 1:
            return 4
        case 2:
            return 1
        default:
            return 0
        }
    }

  // private func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
   // {
     //   let testSection = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TestSection", for: indexPath as IndexPath) as! TestCollectionReusableView
            
            //ヘッダーの背景色は紫、ラベルにセクション名を設定する。
       //     testSection.backgroundColor = UIColor(red: 0.7, green: 0.7,blue: 0.8, alpha: 1.0)
       // testSection.testLabel.text = sectionTitle[indexPath.section]
            
         //   return testSection
            
        //}
        
    //override func didReceiveMemoryWarning() {
      //  super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}
 


    //reusableviewに値を渡すメソッド
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       var reusableView = UICollectionReusableView()
       if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
            if let label = headerView.viewWithTag(3) as? UILabel {
                label.text = sectionTitle[indexPath.section]
            }
            reusableView = headerView
        }
        return reusableView
    }

}
