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
        MockPersonData.testName.person,
        MockPersonData.mother.person,
        MockPersonData.grandMother.person,
        MockPersonData.grandFather.person
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

let allPerson: Person = Person(
    name: "All",
    gender: true,
    imageName: "",
    height: 0.0,
    weight: 0.0,
    bloodType: "",
    birthDate: Date(),
    medicalHistory: [],
    medicalFamily: [],
    allergy: [],
    drugAllergy: [""]
)

enum MockPersonData {
    case testName
    case mother
    case grandMother
    case grandFather
    
    var person: Person {
        switch self {
        case .testName:
            return Person(
                name: "John",
                color: .secondary,
                gender: true,
                imageName: "TestName",
                height: 175.0,
                weight: 70.0,
                bloodType: "O",
                birthDate: Calendar.current.date(from: DateComponents(year: 1990, month: 1, day: 1))!,
                medicalHistory: ["Hypertension"],
                medicalFamily: ["Diabetes"],
                allergy: ["Pollen"],
                drugAllergy: ["Penicillin"]
            )
        case .mother:
            return Person(
                name: "Mother",
                color: .red,
                gender: false,
                imageName: "mother",
                height: 160.0,
                weight: 60.0,
                bloodType: "A",
                birthDate: Calendar.current.date(from: DateComponents(year: 1965, month: 5, day: 15))!,
                medicalHistory: ["Asthma"],
                medicalFamily: ["Hypertension"],
                allergy: ["Dust"],
                drugAllergy: ["None"]
            )
        case .grandMother:
            return Person(
                name: "GrandMother",
                color: .cyan,
                gender: false,
                imageName: "grandmother",
                height: 155.0,
                weight: 55.0,
                bloodType: "B",
                birthDate: Calendar.current.date(from: DateComponents(year: 1940, month: 3, day: 10))!,
                medicalHistory: ["Arthritis"],
                medicalFamily: ["Heart Disease"],
                allergy: ["Nuts"],
                drugAllergy: ["Aspirin"]
            )
        case .grandFather:
            return Person(
                name: "Aunt",
                color: .indigo,
                gender: true,
                imageName: "Aunt",
                height: 170.0,
                weight: 75.0,
                bloodType: "AB",
                birthDate: Calendar.current.date(from: DateComponents(year: 1935, month: 7, day: 20))!,
                medicalHistory: ["Diabetes"],
                medicalFamily: ["Cancer"],
                allergy: ["Shellfish"],
                drugAllergy: ["Ibuprofen"]
            )
        }
    }
}

enum MealTime: String, CaseIterable, Identifiable {
    case breakfastBefore = "Before Breakfast"
    case breakfastAfter = "After Breakfast"
    case lunchBefore = "Before Lunch"
    case lunchAfter = "After Lunch"
    case dinnerBefore = "Before Dinner"
    case dinnerAfter = "After Dinner"
    case sleepBefore = "Before Sleep"
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .breakfastBefore:
            return "Before Breakfast"
        case .breakfastAfter:
            return "After Breakfast"
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
    
    var timeAsDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.date(from: self.time) ?? Date()
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
        
        for i in 0..<10 {
            let medicine = medicines[i % medicines.count]
            let person = persons[i % persons.count]
            let startDate = Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date()
            let notify = false
            let duration = Int.random(in: 5...10)
            let intervalDays = Int.random(in: 1...2) // Random interval between doses in days
            let eatTime = MealTime.allCases.shuffled().prefix(Int.random(in: 1...3)).map { $0 }
            
            let newNotify = MedicineNotify(medicine: medicine, person: person, startDate: startDate, notify: notify, duration: duration, intervalDays: intervalDays, eatTime: eatTime)
            medicineNotifyData.append(newNotify)
        }
        
        return medicineNotifyData
    }
}


func getFakeMedicalInfo () -> String {
    return "\n姓名：\n（Name）\n李文傑\n病歷號碼：\n5768007\n（Chart No.）\n科別：\nBeparim eanp腦血管科\n長庚紀念醫院\nCHANG GUNG MEMORIAL HOSPITAL\n網址：http://www.cgmh.org.™w\n生日：\n怎aeotBitb） 973/05/10\n年齡：\n（Age）\n醫師：\n（Doctor）\n性別：\n51\n張谷州\n男\n（Sex）\n體重：\n（Body Weighl）\n2024/05/15 10:3:00\nS519\n領藥號圖N0.\n11780\n調劑日期；\n（Dispensing Date）\n2024/05/15\n藥師：\n陳怡婷\n（Pharmacist）\n【藥名】\n273 aceta-MINOPHEN 500mg/tab\n56 PC\n1\n商品名：Acetal 愛舒疼錠\n廠牌：瑞安\n14#*4+0\n【藥品外觀】\n淡黃色•長圓柱形錠劑刻有\"PURZER\"，另一面有”07/07\"字樣\n【使用方法】\n內服藥，口服\n4-2\n每天2次，早、晚服用，每次1粒，28天份\n【臨床用途】1鎮痛2解熱\n【副作用】\n皮䓟瘙癢、便秘、噁心、嘔吐、失眠\n【注意事項】\n1.服藥期間應避免併用酒精性飲料\n2.如有同時服用非本院開立之解熱止痛藥或綜合感冒藥，請告知\n醫師或藥師\n【預約回診】\n2024/08/07星期三腦血管科張谷州醫師上午診28號\n本品建議在 2024/07/17 前用完\nAM\n姓名：\n（Name）\n李文傑\n病歷號碼：\n5768007\n（Chart No.）\n科別：\nBeparim eanp腦血管科\n長庚紀念醫院\nCHANG GUNG MEMORIAL HOSPITAL\n網址：http://www.cgmh.org.™w\n生日：\n怎aeotBitb） 973/05/10\n年齡：\n（Age）\n醫師：\n（Doctor）\n性別：\n51\n張谷州\n男\n（Sex）\n體重：\n（Body Weighl）\n2024/05/15 10:3:00\nS519\n領藥號圖N0.\n11780\n調劑日期；\n（Dispensing Date）\n2024/05/15\n藥師：\n陳怡婷\n（Pharmacist）\n【藥名】\n273 aceta-MINOPHEN 500mg/tab\n56 PC\n1\n商品名：Acetal 愛舒疼錠\n廠牌：瑞安\n14#*4+0\n【藥品外觀】\n淡黃色•長圓柱形錠劑刻有\"PURZER\"，另一面有”07/07\"字樣\n【使用方法】\n內服藥，口服\n4-2\n每天2次，早、晚服用，每次1粒，28天份\n【臨床用途】1鎮痛2解熱\n【副作用】\n皮䓟瘙癢、便秘、噁心、嘔吐、失眠\n【注意事項】\n1.服藥期間應避免併用酒精性飲料\n2.如有同時服用非本院開立之解熱止痛藥或綜合感冒藥，請告知\n醫師或藥師\n【預約回診】\n2024/08/07星期三腦血管科張谷州醫師上午診28號\n本品建議在 2024/07/17 前用完\n"
}

