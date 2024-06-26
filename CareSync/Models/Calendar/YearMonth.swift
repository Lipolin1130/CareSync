//
//  YearMOnth.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import Foundation

public struct YearMonth: Equatable, Hashable {
    public let year: Int
    public let month: Int
    
    public init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    
    public static var current: YearMonth {
        get {
            let today = Date()
            return YearMonth(year: Calendar.current.component(.year, from: today), month: Calendar.current.component(.month, from: today))
        }
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month
    }
    
    public var monthShortString: String {
        get {
            var components = toDateComponents()
            components.day = 1
            components.hour = 0
            components.minute = 0
            components.second = 0
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            return formatter.string(from: Calendar.current.date(from: components)!)
        }
    }
    
    public func addMonth(value: Int) -> YearMonth {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let toDate = self.toDateComponents()

        var components = DateComponents()
        components.month = value

        let addedDate = Calendar.current.date(byAdding: components, to: gregorianCalendar.date(from: toDate)!)!
        let ret = YearMonth(year: Calendar.current.component(.year, from: addedDate), month: Calendar.current.component(.month, from: addedDate))
        return ret
    }
    
    public func diffMonth(value: YearMonth) -> Int {
        var origin = self.toDateComponents()
        origin.day = 1
        origin.hour = 0
        origin.minute = 0
        origin.second = 0
        var new = value.toDateComponents()
        new.day = 1
        new.hour = 0
        new.minute = 0
        new.second = 0
        return Calendar.current.dateComponents([.month], from: Calendar.current.date(from: origin)!, to: Calendar.current.date(from: new)!).month!
    }
    
    public func toDateComponents() -> DateComponents {
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        return components
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.year)
        hasher.combine(self.month)
    }
    
    internal func cellToDate(_ cellIndex: Int, startWithMonday: Bool) -> YearMonthDay {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var toDateComponent = DateComponents()
        toDateComponent.year = self.year
        toDateComponent.month = self.month
        toDateComponent.day = 1
        let toDate = gregorianCalendar.date(from: toDateComponent)!
        let weekday = Calendar.current.component(.weekday, from: toDate) // 1Sun, 2Mon, 3Tue, 4Wed, 5Thu, 6Fri, 7Sat
        var components = DateComponents()
        components.day = cellIndex - weekday + (!startWithMonday ? 1 : weekday == 1 ? (-5) : 2)
        let addedDate = Calendar.current.date(byAdding: components, to: toDate)!
        let year = Calendar.current.component(.year, from: addedDate)
        let month = Calendar.current.component(.month, from: addedDate)
        let day = Calendar.current.component(.day, from: addedDate)
        let isFocusYaerMonth = year == self.year && month == self.month
        let ret = YearMonthDay(year: year, month: month, day: day, isFocusYearMonth: isFocusYaerMonth)
        return ret
    }
}
