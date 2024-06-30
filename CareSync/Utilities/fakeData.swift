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

enum MealTime: String, CaseIterable, Identifiable {
    case breakfastBefore = "Breakfast Before"
    case breakfastAfter = "Breakfast After"
    case lunchBefore = "Before Lunch"
    case lunchAfter = "After Lunch"
    case dinnerBefore = "Before Dinner"
    case dinnerAfter = "After Dinner"
    case sleepBefore = "Before Sleep"
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .breakfastBefore:
            return "Breakfast Before"
        case .breakfastAfter:
            return "Breakfast After"
        case .lunchBefore:
            return "Before Lunch"
        case .lunchAfter:
            return "After Lunch"
        case .dinnerBefore:
            return "Before Dinner"
        case .dinnerAfter:
            return "After Dinner"
        case .sleepBefore:
            return "Before Sleep"
        }
    }
    
    var time: String {
        
        switch self {
        case .breakfastBefore:
            return "7:00 AM"
        case .breakfastAfter:
            return "8:30 AM"
        case .lunchBefore:
            return "12:00 PM"
        case .lunchAfter:
            return "1:30 PM"
        case .dinnerBefore:
            return "6:00 PM"
        case .dinnerAfter:
            return "7:30 PM"
        case .sleepBefore:
            return "10:00 PM"
        }
    }
}


enum MockMedicineData {
    case aspirin
    case ibuprofen
    case paracetamol
    
    var medicine: Medicine {
        switch self {
        case .aspirin:
            return Medicine(name: "Aspirin",
                            appearance: "White round pill",
                            instructions: "Take one pill every 4-6 hours",
                            sideEffect: "Nausea, vomiting",
                            precautions: "Avoid if you have stomach ulcers")
        case .ibuprofen:
            return Medicine(name: "Ibuprofen",
                            appearance: "Brown oval pill",
                            instructions: "Take one pill every 6-8 hours",
                            sideEffect: "Dizziness, headache",
                            precautions: "Take with food to avoid stomach upset")
        case .paracetamol:
            return Medicine(name: "Paracetamol",
                            appearance: "White capsule",
                            instructions: "Take one pill every 4-6 hours",
                            sideEffect: "Liver damage in high doses",
                            precautions: "Do not exceed 4 grams per day")
        }
    }
}

func getAllMedicines() -> [Medicine] {
    let medicines: [Medicine] =  [
        MockMedicineData.aspirin.medicine,
        MockMedicineData.ibuprofen.medicine,
        MockMedicineData.paracetamol.medicine
    ]
    return medicines
}

class MockData {
    static func createMedicineNotifyData() -> [MedicineNotify] {
        let medicines = getAllMedicines()
        
        let persons = getPersons()
        
        var medicineNotifyData: [MedicineNotify] = []
        
        for i in 0..<20 {
            let medicine = medicines[i % medicines.count]
            let person = persons[i % persons.count]
            let startDate = Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date()
            let duration = Int.random(in: 5...10)
            let intervalDays = Int.random(in: 1...2) // Random interval between doses in days
            let eatTime = MealTime.allCases.shuffled().prefix(Int.random(in: 1...3)).map { $0 }
            
            let notify = MedicineNotify(medicine: medicine, person: person, startDate: startDate, duration: duration, intervalDays: intervalDays, eatTime: eatTime)
            medicineNotifyData.append(notify)
        }
        
        return medicineNotifyData
    }
}
