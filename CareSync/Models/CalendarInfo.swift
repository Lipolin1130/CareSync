//
//  Task.swift
//  CareSync
//
//  Created by Mac on 2024/6/11.
//
import SwiftUI

class CalendarInfo: ObservableObject ,Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    @ObservedObject var person: Person
    var alert: Bool
    
    init(taskTitle: String, person: Person, alert: Bool) {
        self.taskTitle = taskTitle
        self.person = person
        self.alert = alert
    }
    
    init(taskTitle: String, person: Person) {
        self.taskTitle = taskTitle
        self.person = person
        self.alert = true
    }
    
    var taskColor: Color {
        return person.color
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