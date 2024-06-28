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
    
    init() {
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
}
