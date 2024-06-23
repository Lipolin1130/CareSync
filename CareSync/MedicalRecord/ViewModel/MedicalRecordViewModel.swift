//
//  MedicalRecordViewModel.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import Foundation

class MedicalRecordViewModel: ObservableObject {
    @Published var medicalRecords: [MedicalRecord] = getMedicalRecords()
    
    var sortedMedicalRecords: [MedicalRecord] {
        medicalRecords.sorted {
            $0.yearMonthDay.toDate() > $1.yearMonthDay.toDate()
        }
    }
}
