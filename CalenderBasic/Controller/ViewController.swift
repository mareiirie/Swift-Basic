//
//  ViewController.swift
//  CalenderBasic
//
//  Created by 入江真礼 on 2019/10/31.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    @IBOutlet weak var headerTitle: UILabel!
    
    private let cellMargin: CGFloat = 2.0
    private let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let datemanager = DateManager()
    enum EnumSection: Int{
        case dayOfWeekSection
        case daySection
        static var allcases: [EnumSection] = [.dayOfWeekSection, .daySection]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datemanager.createDaysForMonth()
        calenderCollectionView.dataSource = self
        headerTitle.text = datemanager.monthString
    }
    
    @IBAction func tappedBack(_ sender: UIButton) {
        datemanager.prevMonth()
        calenderCollectionView.reloadData()
        headerTitle.text = datemanager.monthString
    }
    
    @IBAction func tappedNext(_ sender: UIButton) {
        datemanager.nextMonth()
        calenderCollectionView.reloadData()
        headerTitle.text = datemanager.monthString
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EnumSection.allcases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let enumSection = EnumSection(rawValue: section)else{
            fatalError("enumSection error")
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
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let monthOfDateString = formatter.string(from: datemanager.days[indexPath.row])
        
        if (indexPath.row % 7 == 0) {
            cell.dateLabel.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.dateLabel.textColor = UIColor.lightBlue()
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
        
        guard let enumSection = EnumSection(rawValue: indexPath.section)else{
            fatalError("enumSection error")
        }
        switch enumSection {
        case .dayOfWeekSection:
            cell.dateLabel.text = weekArray[indexPath.row]
        case .daySection:
            cell.dateLabel.text = monthOfDateString
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(weekArray.count)
        let height: CGFloat = width * 1.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
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
