//
//  MedicineDose.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import Foundation

class MedicationDose: Identifiable, ObservableObject {
    let id = UUID().uuidString
    @Published var time: Date
    @Published var complete: Bool
    @Published var notify: Bool
    @Published var medicineName: String
    @Published var person: Person
    
    init(time: Date, complete: Bool, notify: Bool, medicineName: String, person: Person) {
        self.time = time
        self.complete = complete
        self.notify = notify
        self.medicineName = medicineName
        self.person = person
    }
    
    init(time: Date, person: Person, medicineName: String) {
        self.time = time
        self.person = person
        self.medicineName = medicineName
        self.notify = true
        self.complete = false
    }
}
