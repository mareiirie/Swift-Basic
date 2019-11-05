//
//  DateManager.swift
//  CalenderBasic
//
//  Created by 入江真礼 on 2019/10/31.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit
import Foundation

final class DateManager {
    private var calendar = Calendar.current
    private var numberOfItems = 0
    private var firstDate = Date() {
        didSet {
            days = createDaysForMonth()
        }
    }
    var days = [Date]()
    var monthString: String {
        return firstDate.string(format: "YYYY/MM")
    }
    
    init() {
        var component = calendar.dateComponents([.year, .month], from: Date())
        component.day = 1
        guard let fD = calendar.date(from: component) else {
            fatalError("fD error")
        }
        firstDate = fD
        days = createDaysForMonth()
    }
    
    @discardableResult
    func createDaysForMonth() -> [Date] {
        let dayOfTheWeek = calendar.component(.weekday, from: firstDate) - 1
        guard let numberOfWeek = calendar.range(of: .weekOfMonth, in: .month, for: firstDate) else {
            fatalError()
        }
        let numberOfWeeks = numberOfWeek.count
        let numberOfItems = numberOfWeeks * 7
        
        return (0..<numberOfItems).map { i in
            var dateComponents = DateComponents()
            dateComponents.day = i - dayOfTheWeek
            return calendar.date(byAdding: dateComponents, to: firstDate)!
        }
    }
    
    func prevMonth() {
        guard let prevMonth = calendar.date(byAdding: .month, value: -1, to: firstDate) else {
            fatalError("preVmonth error")
        }
        firstDate = prevMonth
    }
    func nextMonth() {
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: firstDate) else {
            fatalError("nextMonth error")
        }
        firstDate = nextMonth
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
