//
//  Medicine.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import Foundation

class Medicine: ObservableObject, Identifiable {
    let id =  UUID().uuidString
    var person: Person
    var startDate: Date
    var endDate: Date
    var notify: Bool
    var frequency: String // TODO: change it
    
    init(person: Person, startDate: Date, endDate: Date, notify: Bool, frequency: String) {
        self.person = person
        self.startDate = startDate
        self.endDate = endDate
        self.notify = notify
        self.frequency = frequency
    }
}
