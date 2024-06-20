//
//  Task.swift
//  CareSync
//
//  Created by Mac on 2024/6/11.
//
import SwiftUI

class CalendarInfo: ObservableObject ,Identifiable {
    var id = UUID().uuidString
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
    
    func getHourMinute() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        dateFormatter.locale = Locale(identifier: "zh_TW")
        return dateFormatter.string(from: time)
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

//
//struct Task: Identifiable, Equatable {
//    var id = UUID().uuidString
//    var title: String
//    var time: Date
//    var notification: Bool = false
//}
//
//struct TaskMetaData: Identifiable, Equatable {
//    var id = UUID().uuidString
//    var task: [Task]
//    var taskDate: Date
//}
//
//struct Tasks: Identifiable, Equatable {
//    var id = UUID().uuidString
//    var allTask: [TaskMetaData]
//    
//    func checkSameDay(currentDate: Date) -> Int {
//        for i in 0..<allTask.count {
//            if allTask[i].taskDate.compare(currentDate) == .orderedSame {
//                return i
//            }
//        }
//        return -1
//    }
//    
//    mutating func add(currentDate: Date, addTask: String, chooseDate: Date) {
//        let result = checkSameDay(currentDate: currentDate)
//        if result > 0 {
//            self.allTask[result].task.append(Task(title: addTask, time: chooseDate))
//        }
//        else {
//            self.allTask.append(TaskMetaData(task: [Task(title: addTask, time: chooseDate)], taskDate: chooseDate))
//        }
//    }
//    
//    mutating func remove(task: TaskMetaData, chooseTime: Task) {
//        let findTask = allTask.firstIndex(of: task)
//        self.allTask[findTask!].task.remove(object: chooseTime)
//        if allTask[findTask!].task.isEmpty {
//            allTask.remove(at: findTask!)
//        }
//    }
//}
//
//func getSampleDate(offset: Int) -> Date{
//    let calender = Calendar.current
//    
//    let date = calender.date(byAdding: .day, value: offset, to: Date())
//    
//    return date ?? Date()
//}
//
