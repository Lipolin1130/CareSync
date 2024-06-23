//
//  MedicalRecordCard.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordCard: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    let selectIndex: Int
    var medicalRecord: MedicalRecord {
        medicalRecordViewModel.sortedMedicalRecords[selectIndex]
    }
    
    var body: some View {
        NavigationLink {
            MedicalRecordDetailView(medicalRecordViewModel: medicalRecordViewModel,
                                    selectIndex: selectIndex)
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(medicalRecord.yearMonthDay.year)")
                    .font(.caption)
                
                Text(medicalRecord.yearMonthDay.toWeekString())
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(medicalRecord.hospitalName)
                
                Text(medicalRecord.person.name)
            }
            .padding(10)
            .frame(width: 300 ,height: 150, alignment: .topLeading)
            .foregroundColor(.white)
            .background(medicalRecord.person.color.opacity(0.5))
            .cornerRadius(20)
        }
    }
}

#Preview {
    MedicalRecordCard(medicalRecordViewModel: MedicalRecordViewModel(),
                      selectIndex: 0)
}
