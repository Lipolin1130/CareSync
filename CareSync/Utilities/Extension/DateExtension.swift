//
//  DataExtension.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import Foundation
import SwiftUI

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func toYearMonthDay() -> YearMonthDay {
        YearMonthDay(year: year, month: month, day: day)
    }
    
    func adding(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(for: self) ?? ""
    }
}

extension Binding where Value == Date? {
    func toNonOptional(defaultValue: Date = Date()) -> Binding<Date> {
        return Binding<Date>(
            get: { self.wrappedValue ?? defaultValue },
            set: { newValue in self.wrappedValue = newValue }
        )
    }
}
