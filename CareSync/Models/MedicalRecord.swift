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
    @Published var date: Date
    @Published var hospitalName: String
    @Published var hospitalLocation: String
    @Published var symptomDescription: String
    @Published var doctorOrder: String
    @Published var appointment: Bool
    @Published var appointmentDay: Date?
    
    init(person: Person, yearMonthDay: YearMonthDay, hospitalName: String, hospitalLocation: String, symptomDescription: String, doctorOrder: String, appointment: Bool, appointmentDay: YearMonthDay? = nil) {
        self.person = person
        self.date = CalendarInfo.settingTime(yearMonthDay: yearMonthDay,
                                                     hour: Int.random(in: 0...23),
                                                     minute: Int.random(in: 0...59))
        self.hospitalName = hospitalName
        self.hospitalLocation = hospitalLocation
        self.symptomDescription = symptomDescription
        self.doctorOrder = doctorOrder
        self.appointment = appointment
        if let appointmentDay = appointmentDay {
            self.appointmentDay = CalendarInfo.settingTime(yearMonthDay: appointmentDay,
                                                           hour: Int.random(in: 0...23),
                                                           minute: Int.random(in: 0...59))
        }
    }
    
    init(person: Person) {
        self.person = person
        self.date = Date()
        self.hospitalName = "Hospital"
        self.hospitalLocation = "Location"
        self.symptomDescription = ""
        self.doctorOrder = ""
        self.appointment = false
    }
}
