//
//  DateManager.swift
//  CalenderBasic
//
//  Created by 入江真礼 on 2019/10/31.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit
import Foundation

protocol AlertDelegate {
    func dispAlert(titleString: String, messageString: String)
}

final class DateManager {
    var alertdelegate: AlertDelegate?
    var calendar = Calendar.current
    var firstDate = Date() {
        didSet {
            days = createDaysForMonth()
            allDatesArray = createDates()
            datesArray = createSelfDates()
            inactiveArray = subtractionArrays()
        }
    }
    var days = [String]()
    var allDatesArray = [Date]()
    var datesArray = [Date]()
    var inactiveArray = [Int]()
    var monthString: String {
        return firstDate.string()
    }
    
    init() {
        var component = calendar.dateComponents([.year, .month], from: Date())
        component.day = 1
        guard let fD = calendar.date(from: component) else {
            fatalError("fD nil")
        }
        firstDate = fD
        days = createDaysForMonth()
        allDatesArray = createDates()
        datesArray = createSelfDates()
        inactiveArray = subtractionArrays()
    }
    
    //セルに返すdateを"dd"で返すメソッド
    @discardableResult
    func createDaysForMonth() -> [String] {
        let dayOfTheWeek = calendar.component(.weekday, from: firstDate) - 1
        guard let numberOfWeek = calendar.range(of: .weekOfMonth, in: .month, for: firstDate) else {
            fatalError("numberOfWeek nil")
        }
        let numberOfWeeks = numberOfWeek.count
        let numberOfItems = numberOfWeeks * 7
        
        return (0..<numberOfItems).map { i in
            var dateComponents = DateComponents()
            dateComponents.day = i - dayOfTheWeek
            guard let datesDate = calendar.date(byAdding: dateComponents,to: firstDate) else{
                fatalError("datesDate nil")
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            let dates = formatter.string(from: datesDate)
            return dates
        }
    }
    
    //①当月分のdateを配列にするメソッド
    func createSelfDates () -> [Date] {
        guard let rangeOfDates = calendar.range(of: .day, in: .month, for: firstDate) else {
            fatalError("rangeOfDates nil")
        }
        let numberOfDates = rangeOfDates.count
        return (0..<numberOfDates).map { i in
            var dateComponents = DateComponents()
            dateComponents.day = i
            guard let selfDates = calendar.date(byAdding: dateComponents, to: firstDate) else{
                fatalError("selfDates nil")
            }
            return selfDates
        }
    }
    
    //②表示する全てのdateを配列にするメソッド
    func createDates() -> [Date] {
        let dayOfTheWeek = calendar.component(.weekday, from: firstDate) - 1
        guard let numberOfWeek = calendar.range(of: .weekOfMonth, in: .month, for: firstDate) else {
            fatalError("numberOfWeek nil")
        }
        let numberOfWeeks = numberOfWeek.count
        let numberOfItems = numberOfWeeks * 7
        return (0..<numberOfItems).map { i in
            var dateComponents = DateComponents()
            dateComponents.day = i - dayOfTheWeek
            guard let datesDate = calendar.date(byAdding: dateComponents, to: firstDate) else{
                fatalError("datesDate nil")
            }
            return datesDate
        }
    }
    
    //③上記二つのメソッドの差分を配列化し、そのindex番号を[Int]に返すメソッド
    func subtractionArrays() -> [Int] {
        let res = allDatesArray.filter { v in return !datesArray.contains(v) }
        for elements in res {
            guard let indexElements = allDatesArray.firstIndex(of: elements) else {
                fatalError("indexElement nil")
            }
            inactiveArray.append(indexElements)
        }
        return inactiveArray
    }
    
    //「前へ」ボタンが押されると呼ばれる(指定の月を超えるとreturnされる)
    func prevMonth() {
        inactiveArray = [Int]()
        guard let prevMonth = calendar.date(byAdding: .month, value: -1, to: firstDate) else {
            fatalError("preVmonth nil")
        }
        guard let lowerDate = calendar.date(from: DateComponents(year: 2019, month: 4, day: 2)) else {
            fatalError("lowerDate nil")
        }
        if firstDate < lowerDate {
            alertdelegate?.dispAlert(titleString: "アラート", messageString: "2019年度以前は表示できません")
            print("下限")
            return
        }
        firstDate = prevMonth
    }
    //「次へ」ボタンが押されると呼ばれる（指定の月を超えるとreturnされる）
    func nextMonth() {
        inactiveArray = [Int]()
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: firstDate) else {
            fatalError("nextMonth nil")
        }
        guard let upperDate = calendar.date(from: DateComponents(year: 2020, month: 2, day: 28)) else {
            fatalError("upperDate nil")
        }
        if firstDate > upperDate {
            alertdelegate?.dispAlert(titleString: "アラート", messageString: "2019年度以降は表示できません")
            print("上限")
            return
        }
        firstDate = nextMonth
    }
    
}

extension Date {
    func string() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        return formatter.string(from: self)
    }
}
