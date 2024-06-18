//
//  CalendarInfoViewModel.swift
//  CareSync
//
//  Created by Mac on 2024/6/14.
//

import SwiftUI

class CalendarInfoViewModel: ObservableObject {
    @Published var information: [YearMonthDay: [CalendarInfo]] = getInformation()
    @Published var filteredInformation: [YearMonthDay: [CalendarInfo]] = [:]
    @Published var pickerSelect: Int = 0
    
    var persons: [Person]
    
    init(persons: [Person]) {
        self.persons = persons
        filterInformation(for: persons[pickerSelect].name)
    }
    
    func filterInformation(for personName: String) {
        if personName == "All" {
            filteredInformation = information
        } else {
            filteredInformation = information.reduce(into: [YearMonthDay: [CalendarInfo]]()) { result, entry in
                let (date, infos) = entry
                result[date] = infos.filter { $0.person.name == personName }
            }
        }
    }
    
    func toggleAlert(for date: YearMonthDay, at index: Int) {
        guard let infos = information[date] else { return }
        infos[index].alert.toggle()
        information[date] = infos
        print("Alert toggled for item at index \(index) on date \(date)")
        filterInformation(for: persons[pickerSelect].name)
    }
    
    func updatePickerSelection(to newIndex: Int) {
        pickerSelect = newIndex
        filterInformation(for: persons[newIndex].name)
    }
    
    func deleteInfo(yearMonthDay: YearMonthDay, id: String) {
        if var info = information[yearMonthDay] {
            info.removeAll { $0.id == id }
            
            if info.isEmpty {
                information.removeValue(forKey: yearMonthDay)
            } else {
                information[yearMonthDay] = info
            }
        }
        filterInformation(for: persons[pickerSelect].name)
    }
}
