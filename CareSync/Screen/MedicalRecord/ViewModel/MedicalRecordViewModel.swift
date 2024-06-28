//
//  MedicalRecordViewModel.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import Foundation

class MedicalRecordViewModel: ObservableObject {
    @Published var medicalRecords: [MedicalRecord] = getMedicalRecords()
    @Published var filteredRecords: [MedicalRecord] = []
    @Published var personSelect: Int = 0
    
    var persons: [Person]
    
    
    var selectedPerson: Person {
        return personSelect == 0 ? allPerson : persons[personSelect - 1]
    }
    
    init(persons: [Person]) {
        self.persons = persons
        filterInformation(for: selectedPerson.name)
    }
    
    func filterInformation(for personName: String) {
        if personName == "All" {
            filteredRecords = medicalRecords
        } else {
            filteredRecords = medicalRecords.filter { $0.person.name == personName}
        }
    }
    
    func updateSelection(to newIndex: Int) {
        personSelect = newIndex
        filterInformation(for: selectedPerson.name)
    }
}