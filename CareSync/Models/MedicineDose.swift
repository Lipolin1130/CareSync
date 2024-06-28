//
//  MedicineDose.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import Foundation

class MedicationDose: Identifiable {
    let id = UUID().uuidString
    var time: Date
    var complete: Bool
    var notify: Bool
    init(time: Date, complete: Bool, notify: Bool) {
        self.time = time
        self.complete = complete
        self.notify = notify
    }
    
    init(time: Date) {
        self.time = time
        self.complete = false
        self.notify = false
    }
}
