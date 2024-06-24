//
//  MedicalRecord.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

class MedicalRecord: ObservableObject, Identifiable {
    
    let id = UUID().uuidString
    @Published var person: Person
    @Published var yearMonthDay: YearMonthDay
    @Published var hospitalName: String
    @Published var hospitalLocation: String?
    @Published var symptomDescription: String?
    @Published var doctorOrder: String?
    @Published var appointment: Bool
    @Published var appointmentDay: YearMonthDay?
    
    init(person: Person, yearMonthDay: YearMonthDay, hospitalName: String, hospitalLocation: String? = nil, symptomDescription: String? = nil, doctorOrder: String? = nil, appointment: Bool, appointmentDay: YearMonthDay? = nil) {
        self.person = person
        self.yearMonthDay = yearMonthDay
        self.hospitalName = hospitalName
        self.hospitalLocation = hospitalLocation
        self.symptomDescription = symptomDescription
        self.doctorOrder = doctorOrder
        self.appointment = appointment
        self.appointmentDay = appointmentDay
    }
    
    init(person: Person) {
        self.person = person
        self.yearMonthDay = YearMonthDay.current
        self.hospitalName = "Hospital"
        self.hospitalLocation = "Location"
        self.symptomDescription = ""
        self.doctorOrder = ""
        self.appointment = false
    }
}
