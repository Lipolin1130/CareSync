//
//  MedicineNotify.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import Foundation

class MedicineNotify: ObservableObject, Identifiable {
    let id =  UUID().uuidString
    @Published var medicine: Medicine
    @Published var person: Person
    @Published var startDate: Date
    @Published var notify: Bool
    @Published var duration: Int // how many days you need to eat medicine
    @Published var intervalDays: Int // interval in days between each dose
    @Published var eatTime: [MealTime] // times to take the medicine decided by MealTime
    @Published var medicationDose: [MedicationDose]
    
    var eatTimeDescription: String {
        eatTime
            .sorted{ $0.timeAsDate < $1.timeAsDate }
            .map { $0.time }
            .joined(separator: ", ")
    }
    
    var completeDoses: Int {
        medicationDose.filter { $0.complete }.count
    }
    
    init(medicine: Medicine, person: Person, startDate: Date, notify: Bool, duration: Int, intervalDays: Int, eatTime: [MealTime]) {
        self.medicine = medicine
        self.person = person
        self.startDate = startDate
        self.notify = notify
        self.duration = duration
        self.intervalDays = intervalDays
        self.eatTime = eatTime
        self.medicationDose = []
        if !eatTime.isEmpty {
            self.medicationDose = computeMedicationDose()
        }
    }
    
    init() {
        self.medicine = Medicine()
        self.person = getPersons()[0]
        self.startDate = Date()
        self.notify = false
        self.duration = 3
        self.intervalDays = 1
        self.eatTime = []
        self.medicationDose = []
    }
    
    func computeMedicationDose() -> [MedicationDose] {
        var doses: [MedicationDose] = []
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let currentHour = calendar.component(.hour, from: startDate)
        let currentMinute = calendar.component(.minute, from: startDate)
        
        var validEatTimes = eatTime.filter { time in
            if let mealTime = dateFormatter.date(from: time.time) {
                let components = calendar.dateComponents([.hour, .minute], from: mealTime)
                if components.hour! > currentHour || (components.hour == currentHour && components.minute! > currentMinute) {
                    return true
                }
            }
            return false
        }
        
        for day in stride(from: 0, to: duration, by: intervalDays) {
            guard let currentDay = calendar.date(byAdding: .day, value: day, to: startDate) else { continue }
            
            if day > 0 {
                validEatTimes = eatTime
            }
            
            for time in validEatTimes {
                if let mealTime = dateFormatter.date(from: time.time) {
                    var components = calendar.dateComponents([.hour, .minute], from: mealTime)
                    components.year = currentDay.year
                    components.month = currentDay.month
                    components.day = currentDay.day
                    components.timeZone = TimeZone.current
                    
                    if let doseTime = calendar.date(from: components) {
                        doses.append(MedicationDose(time: doseTime, person: person, medicineName: medicine.name))
                    }
                }
            }
        }
        return doses
    }
}
