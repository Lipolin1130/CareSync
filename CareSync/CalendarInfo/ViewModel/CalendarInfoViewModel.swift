//
//  CalendarInfoViewModel.swift
//  CareSync
//
//  Created by Mac on 2024/6/14.
//

import SwiftUI

class CalendarInfoViewModel: ObservableObject {
    @Published var informations: [YearMonthDay: [CalendarInfo]] = getInformation()
    @Published var filteredInformation: [YearMonthDay: [CalendarInfo]] = [:]
    @Published var pickerSelect: Int = 0
    @Published var focusDate: YearMonthDay = YearMonthDay.current
    @Published var infoDetailSheet: Bool = false
    
    var persons: [Person]
    
    init(persons: [Person]) {
        self.persons = persons
        filterInformation(for: selectedPerson.name)
    }
    
    var selectedPerson: Person {
        return pickerSelect == 0 ? allPerson : persons[pickerSelect - 1]
    }
    
    func filterInformation(for personName: String) {
        if personName == "All" {
            filteredInformation = informations
        } else {
            filteredInformation = informations.reduce(into: [YearMonthDay: [CalendarInfo]]()) { result, entry in
                let (date, infos) = entry
                result[date] = infos.filter { $0.person?.name == personName }
            }
        }
    }
    
    func toggleNotify(for date: YearMonthDay, at index: Int) {
        guard let infos = informations[date] else { return }
        infos[index].notify.toggle()
        filterInformation(for: selectedPerson.name)
    }
    
    func updatePickerSelection(to newIndex: Int) {
        pickerSelect = newIndex
        filterInformation(for: selectedPerson.name)
    }
    
    func deleteInfo(yearMonthDay: YearMonthDay, id: String) {
        if var info = informations[yearMonthDay] {
            info.removeAll { $0.id == id }
            
            if info.isEmpty {
                informations.removeValue(forKey: yearMonthDay)
            } else {
                informations[yearMonthDay] = info
            }
        }
        filterInformation(for: selectedPerson.name)
    }
    
    func addInfo(yearMonthDay: YearMonthDay, information: CalendarInfo) {
        if informations[yearMonthDay] != nil {
            informations[yearMonthDay]?.append(information)
        } else {
            informations[yearMonthDay] = [information]
        }
        
        filterInformation(for: selectedPerson.name)
    }
}
