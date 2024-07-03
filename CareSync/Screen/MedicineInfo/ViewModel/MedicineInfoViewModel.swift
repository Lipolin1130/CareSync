//
//  MedicineInfoViewModel.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import Foundation

class MedicineInfoViewModel: ObservableObject {
    @Published var medicineNotify: [MedicineNotify] = MockData.createMedicineNotifyData()
    @Published var currentDay: Date = Date()
    @Published var currentWeek: [Date] = []
    @Published var filterMedicationDose: [MedicationDose]?
    @Published var addMedicineInfoSheet: Bool = false
    @Published var addMedicineInfo: MedicineNotify = MedicineNotify()
    
    var persons: [Person]
    
    var eatTimeDescription: String {
        addMedicineInfo.eatTime.map { $0.time }.joined(separator: ", ")
    }
    
    init(persons: [Person]) {
        self.persons = persons
        fetchCurrentWeek()
        filterDose()
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach {day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func checkIsToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func filterDose() {
        let allDoses = medicineNotify.flatMap { $0.medicationDose }
        filterMedicationDose = allDoses.filter { isToday(date: $0.time) }
            .sorted {dose1, dose2 in
                return dose1.time < dose2.time
            }
    }
    
    func printAddMedicineInfo() {
        addMedicineInfo.medicationDose = addMedicineInfo.computeMedicationDose()
        let medicine = addMedicineInfo.medicine
        let person = addMedicineInfo.person
        let startDate = extractDate(date: addMedicineInfo.startDate, format: "yyyy-MM-dd")
        let duration = addMedicineInfo.duration
        let intervalDays = addMedicineInfo.intervalDays
        let eatTimeDescriptions = addMedicineInfo.eatTime.map { $0.description }.joined(separator: ", ")
        let medicationDoses = addMedicineInfo.medicationDose.map { extractDate(date: $0.time, format: "yyyy-MM-dd HH:mm") }.joined(separator: ", ")
        
        print("Medicine Info:")
        print("  Name: \(medicine.name)")
        print("  Appearance: \(medicine.appearance)")
        print("  Instructions: \(medicine.instructions)")
        print("  Precautions: \(medicine.precautions)")
        print("  Side Effect: \(medicine.sideEffect)")
        print("Person Info:")
        print("  Name: \(person.name)")
        print("  Color: \(person.color.description)")
        print("Schedule Info:")
        print("  Start Date: \(startDate)")
        print("  Duration: \(duration) days")
        print("  Interval Days: \(intervalDays)")
        print("  Eat Times: \(eatTimeDescriptions)")
        print("Medication Doses:")
        print("  Doses: \(medicationDoses)")
    }
    
    func addNewMedicineNotify() {
        addMedicineInfo.medicationDose = addMedicineInfo.computeMedicationDose()
        medicineNotify.append(addMedicineInfo)
        addMedicineInfoSheet.toggle()
        addMedicineInfo = MedicineNotify()
        filterDose()
    }
}
