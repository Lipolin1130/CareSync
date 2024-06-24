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
    informations[date]?.append(CalendarInfo(taskTitle: "Meeting with Client", person: persons[0], notify: false, time: Date()))
    informations[date]?.append(CalendarInfo(taskTitle: "Doctor Appointment", person: persons[0], notify: false, time: Date()))
    
    date = date.addDay(value: 1)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Team Standup", person: persons[2], notify: false, yearMonthDay: date))
    informations[date]?.append(CalendarInfo(taskTitle: "Team Standup", person: persons[1], notify: false, yearMonthDay: date))
    informations[date]?.append(CalendarInfo(taskTitle: "Code Refactoring", person: persons[3], yearMonthDay: date))
    informations[date]?.append(CalendarInfo(taskTitle: "Code", person: persons[0], yearMonthDay: date))
    informations[date]?.append(CalendarInfo(taskTitle: "Review", person: persons[1], yearMonthDay: date))
    
    date = date.addDay(value: 2)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Project Review", person: persons[0], yearMonthDay: date))
    informations[date]?.append(CalendarInfo(taskTitle: "Project", person: persons[3], yearMonthDay: date))
    
    date = date.addDay(value: 4)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Code Refactoring", person: persons[1], yearMonthDay: date))
    
    date = date.addDay(value: -10)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Performance Review", person: persons[2], notify: false, yearMonthDay: date))
    
    date = date.addDay(value: -2)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Strategy Meeting", person: persons[0], yearMonthDay: date))
    
    date = date.addDay(value: -6)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Quarterly Planning", person: persons[3], yearMonthDay: date))
    
    date = date.addDay(value: -3)
    informations[date] = []
    informations[date]?.append(CalendarInfo(taskTitle: "Sales Presentation", person: persons[1], yearMonthDay: date))
    
    return informations
}

func getPersons() -> [Person] {
    let persons: [Person] = [
            Person(name: "testName"),
            Person(name: "mother", color: Color.pink),
            Person(name: "grandMother", color: Color.cyan),
            Person(name: "grandFather", color: Color.indigo),
    ]
    return persons
}

func getMedicalRecords() -> [MedicalRecord] {
    let persons = getPersons()
    let medicalRecords: [MedicalRecord] = [
        MedicalRecord(person: persons[0], yearMonthDay: YearMonthDay(year: 2024, month: 6, day: 15), hospitalName: "City Hospital", hospitalLocation: "City Center", symptomDescription: "Fever and cough", doctorOrder: "Rest and hydration", appointment: true, appointmentDay: YearMonthDay(year: 2024, month: 6, day: 20)),
        MedicalRecord(person: persons[1], yearMonthDay: YearMonthDay(year: 2024, month: 6, day: 10), hospitalName: "County Hospital", hospitalLocation: "East Side", symptomDescription: "Headache", doctorOrder: "Painkillers", appointment: false),
        MedicalRecord(person: persons[2], yearMonthDay: YearMonthDay(year: 2024, month: 6, day: 20), hospitalName: "General Hospital", hospitalLocation: "North Area", symptomDescription: "Stomach ache", doctorOrder: "Antacids", appointment: true, appointmentDay: YearMonthDay(year: 2024, month: 6, day: 27)),
        MedicalRecord(person: persons[3], yearMonthDay: YearMonthDay(year: 2024, month: 6, day: 5), hospitalName: "District Hospital", hospitalLocation: "South End", symptomDescription: "Back pain", doctorOrder: "Physiotherapy", appointment: true, appointmentDay: YearMonthDay(year: 2024, month: 6, day: 12)),
        MedicalRecord(person: persons[0], yearMonthDay: YearMonthDay(year: 2024, month: 6, day: 25), hospitalName: "City Hospital", hospitalLocation: "City Center", symptomDescription: "Sore throat", doctorOrder: "Antibiotics", appointment: false),
        MedicalRecord(person: persons[1], yearMonthDay: YearMonthDay(year: 2024, month: 7, day: 15), hospitalName: "County Hospital", hospitalLocation: "East Side", symptomDescription: "High blood pressure", doctorOrder: "Lifestyle changes", appointment: true, appointmentDay: YearMonthDay(year: 2024, month: 7, day: 22)),
        MedicalRecord(person: persons[2], yearMonthDay: YearMonthDay(year: 2024, month: 7, day: 5), hospitalName: "General Hospital", hospitalLocation: "North Area", symptomDescription: "Allergic reaction", doctorOrder: "Antihistamines", appointment: true, appointmentDay: YearMonthDay(year: 2024, month: 7, day: 12)),
        MedicalRecord(person: persons[3], yearMonthDay: YearMonthDay(year: 2024, month: 7, day: 25), hospitalName: "District Hospital", hospitalLocation: "South End", symptomDescription: "Joint pain", doctorOrder: "Pain management", appointment: false),
        MedicalRecord(person: persons[0], yearMonthDay: YearMonthDay(year: 2024, month: 7, day: 10), hospitalName: "City Hospital", hospitalLocation: "City Center", symptomDescription: "Flu symptoms", doctorOrder: "Rest and fluids", appointment: false),
        MedicalRecord(person: persons[1], yearMonthDay: YearMonthDay(year: 2024, month: 6, day: 8), hospitalName: "County Hospital", hospitalLocation: "East Side", symptomDescription: "Migraine", doctorOrder: "Pain relief", appointment: true, appointmentDay: YearMonthDay(year: 2024, month: 6, day: 15))
    ]
    return medicalRecords
}

let allPerson: Person = Person(name: "All")

enum MockPersonData {
    case testName
    case mother
    case grandMother
    case grandFather
    
    var person: Person {
        switch self {
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
