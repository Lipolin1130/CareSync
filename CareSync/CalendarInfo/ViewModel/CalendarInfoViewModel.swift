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
            filteredInformation = information.mapValues { infos in
                infos.filter { $0.person.name == personName }
            }
        }
    }
    
    func toggleAlert(for date: YearMonthDay, at index: Int) {
        information[date]?[index].alert.toggle()
    }
    
    func updatePickerSelection(to newIndex: Int) {
        pickerSelect = newIndex
        filterInformation(for: persons[newIndex].name)
    }
}
