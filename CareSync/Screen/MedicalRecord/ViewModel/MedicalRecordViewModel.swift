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
    @Published var medicalRecordAdd: MedicalRecord = MedicalRecord(person: getPersons()[0])
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
    
    func printAddMedicalRecord() {
        print("Medical Record:")
        print("ID: \(medicalRecordAdd.id)")
        print("Person: \(medicalRecordAdd.person.name)")
        print("Date: \(medicalRecordAdd.date)")
        print("Hospital Name: \(medicalRecordAdd.hospitalName)")
        print("Hospital Location: \(medicalRecordAdd.hospitalLocation)")
        print("Symptom Description: \(medicalRecordAdd.symptomDescription)")
        print("Doctor Order: \(medicalRecordAdd.doctorOrder)")
        print("Appointment: \(medicalRecordAdd.appointment)")
        if let appointmentDay = medicalRecordAdd.appointmentDay {
            print("Appointment Day: \(appointmentDay)")
        } else {
            print("Appointment Day: N/A")
        }
    }
    
    func addMedicalRecords() {
        medicalRecords.append(medicalRecordAdd)
        
        if medicalRecordAdd.appointment {
            let medicalRecordAddNew = MedicalRecord(person: medicalRecordAdd.person,
                                                    date: medicalRecordAdd.appointmentDay!,
                                                    hospitalName: medicalRecordAdd.hospitalName,
                                                    hospitalLocation: medicalRecordAdd.hospitalLocation,
                                                    symptomDescription: "",
                                                    doctorOrder: "",
                                                    appointment: false)
            medicalRecords.append(medicalRecordAddNew)
        }
        filterInformation(for: selectedPerson.name)
        medicalRecordAdd = MedicalRecord(person: getPersons()[0])
    }
}
