//
//  ViewController.swift
//  CalenderBasic
//
//  Created by 入江真礼 on 2019/10/31.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    private let cellMargin: CGFloat = 2.0
    private let weekArray = ["日", "月", "火", "水", "木", "金", "土"]
    private let datemanager = DateManager()
    enum EnumSection: Int, CaseIterable{
        case dayOfWeekSection
        case daySection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datemanager.createDaysForMonth()
        calenderCollectionView.dataSource = self
        calenderCollectionView.delegate = self
        titleLabel.text = datemanager.monthString
        datemanager.alertdelegate = self
    }
    
    @IBAction func tappedBack(_ sender: UIButton) {
        datemanager.prevMonth()
        calenderCollectionView.reloadData()
        titleLabel.text = datemanager.monthString
    }
    
    @IBAction func tappedNext(_ sender: UIButton) {
        datemanager.nextMonth()
        calenderCollectionView.reloadData()
        titleLabel.text = datemanager.monthString
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EnumSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let enumSection = EnumSection(rawValue: section)else{
            fatalError("enumSection nil")
        }
        switch enumSection {
        case .dayOfWeekSection:
            return weekArray.count
        case .daySection:
            return datemanager.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: "calendarcell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarcell", for: indexPath) as! CalendarCell
        
        if (indexPath.row % 7 == 0) {
            cell.dateLabel.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.dateLabel.textColor = UIColor.lightBlue()
        } else {
            cell.dateLabel.textColor = UIColor.black
        }
        
        guard let enumSection = EnumSection(rawValue: indexPath.section)else{
            fatalError("enumSection nil")
        }
        switch enumSection {
        case .dayOfWeekSection:
            cell.dateLabel.text = weekArray[indexPath.row]
        case .daySection:
            cell.dateLabel.text = datemanager.days[indexPath.row]
            if datemanager.inactiveArray.contains(indexPath.row) {
                cell.dateLabel.textColor = UIColor.gray
            }
        }
        return cell
    }
    
}

extension CalendarViewController: AlertDelegate{
    //    年度外の月を指定した際のアラート
    func dispAlert(titleString: String, messageString: String) {
        let title = titleString
        let message = messageString
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = floor(collectionView.bounds.width/7)
        let cellHeight = floor(collectionView.bounds.height/7)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
