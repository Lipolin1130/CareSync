//
//  Task.swift
//  CareSync
//
//  Created by Mac on 2024/6/11.
//
import SwiftUI

class CalendarInfo: ObservableObject ,Identifiable {
    let id = UUID().uuidString
    @Published var taskTitle: String
    @Published var person: Person?
    @Published var notify: Bool
    @Published var time: Date
    
    init(taskTitle: String, person: Person, notify: Bool, time: Date) {
        self.taskTitle = taskTitle
        self.person = person
        self.notify = notify
        self.time = time
    }
    
    init(taskTitle: String, person: Person, notify: Bool, yearMonthDay: YearMonthDay) {
        self.taskTitle = taskTitle
        self.person = person
        self.notify = notify
        self.time = CalendarInfo.settingTime(yearMonthDay: yearMonthDay, 
                                             hour: Int.random(in: 0...23),
                                             minute: Int.random(in: 0...59))
    }
    
    init(taskTitle: String, person: Person, yearMonthDay: YearMonthDay) {
        self.taskTitle = taskTitle
        self.person = person
        self.notify = Bool.random()
        self.time = CalendarInfo.settingTime(yearMonthDay: yearMonthDay, 
                                             hour: Int.random(in: 0...23),
                                             minute: Int.random(in: 0...59))
    }
    
    init(taskTitle: String, person: Person) {
        self.taskTitle = taskTitle
        self.person = person
        self.notify = true
        self.time = Date()
    }
    
    init(taskTitle: String) {
        self.taskTitle = taskTitle
        self.notify = true
        self.time = Date()
    }
    
    init(yearMonthDay: YearMonthDay) {
        self.taskTitle = ""
        self.notify = Bool.random()
        self.time = CalendarInfo.settingTime(yearMonthDay: yearMonthDay, 
                                             hour: Int.random(in: 0...23),
                                             minute: Int.random(in: 0...59))
    }
    
    init() {
        self.taskTitle = ""
        self.notify = true
        self.time = Date()
    }
    
    
    var taskColor: Color {
        return person?.color ?? Color.primary
    }
    
    static func settingTime(yearMonthDay: YearMonthDay, hour: Int, minute: Int) -> Date {
        var component = DateComponents()
        component.year = yearMonthDay.year
        component.month = yearMonthDay.month
        component.day = yearMonthDay.day
        component.hour = hour
        component.minute = minute
        return Calendar.current.date(from: component)!
    }
    
    func getYearMonthDay() -> YearMonthDay {
        return YearMonthDay(
            year: Calendar.current.component(.year, from: time),
            month: Calendar.current.component(.month, from: time),
            day: Calendar.current.component(.day, from: time))
    }
}
