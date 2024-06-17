//
//  fakeData.swift
//  CareSync
//
//  Created by Mac on 2024/6/12.
//

import SwiftUI

func getInformation() -> [YearMonthDay: [CalendarInfo]] {
    var informations = [YearMonthDay: [CalendarInfo]]()
    var date = YearMonthDay.current
    let persons = [MockPersonData.mother.person, MockPersonData.grandFather.person, MockPersonData.grandMother.person, MockPersonData.testName.person]
    
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Meeting with Client", person: persons[0], alert: false))
    informations[date]?.append(CalendarInfo(taskTitle: "Doctor Appointment", person: persons[0], alert: false))
    
    date = date.addDay(value: 1)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Team Standup", person: persons[2], alert: false))
    informations[date]?.append(CalendarInfo(taskTitle: "Team Standup", person: persons[1], alert: false))
    informations[date]?.append(CalendarInfo(taskTitle: "Code Refactoring", person: persons[3]))
    informations[date]?.append(CalendarInfo(taskTitle: "Code", person: persons[0]))
    informations[date]?.append(CalendarInfo(taskTitle: "Review", person: persons[1]))
    
    date = date.addDay(value: 2)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Project Review", person: persons[0]))
    informations[date]?.append(CalendarInfo(taskTitle: "Project", person: persons[3]))
    
    date = date.addDay(value: 4)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Code Refactoring", person: persons[1]))
    
    date = date.addDay(value: -10)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Performance Review", person: persons[2], alert: false))
    
    date = date.addDay(value: -2)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Strategy Meeting", person: persons[0]))
    
    date = date.addDay(value: -6)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Quarterly Planning", person: persons[3]))
    
    date = date.addDay(value: -3)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Sales Presentation", person: persons[1]))
    
    return informations
}

func getPersons() -> [Person] {
    let persons: [Person] = [
        Person(name: "All"),
        Person(name: "testName"),
        Person(name: "mother", color: Color.pink),
        Person(name: "grandMother", color: Color.cyan),
        Person(name: "grandFather", color: Color.indigo),
    ]
    return persons
}

enum MockPersonData {
    case all
    case testName
    case mother
    case grandMother
    case grandFather
    
    var person: Person {
        switch self {
        case .all:
            return Person(name: "All")
        case .testName:
            return Person(name: "testName")
        case .mother:
            return Person(name: "mother", color: .red)
        case .grandMother:
            return Person(name: "grandMother", color: .cyan)
        case .grandFather:
            return Person(name: "grandFather", color: .indigo)
        }
    }
}
