//
//  MedicalRecordCard.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordCard: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
//    let selectIndex: Int
    @ObservedObject var medicalRecord: MedicalRecord
//    var medicalRecord: MedicalRecord {
//        medicalRecordViewModel.filteredRecords.sorted(by: {$0.yearMonthDay.toDate() > $1.yearMonthDay.toDate()})[selectIndex]
//    }
    
    var body: some View {
        NavigationLink {
            MedicalRecordDetailView(medicalRecordViewModel: medicalRecordViewModel,
                                    medicalRecord: medicalRecord)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text("\(medicalRecord.yearMonthDay.year)")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text(medicalRecord.person.name)
                        .padding(3)
                        .font(.subheadline)
                        .background(.white)
                        .bold()
                        .foregroundStyle(medicalRecord.person.color)
                        .cornerRadius(5)
                }
                
                Text(medicalRecord.yearMonthDay.toWeekString())
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(medicalRecord.hospitalName)
                    .font(.subheadline)
                
                if medicalRecord.appointment {
                    Text("Appointment: \(medicalRecord.appointmentDay?.toWeekString() ?? "")")
                        .font(.subheadline)
                        .italic()
                }
            }
            .padding(10)
            .frame(width: 300 ,height: 125, alignment: .topLeading)
            .foregroundColor(.white)
            .background(medicalRecord.person.color.opacity(0.5))
            .cornerRadius(20)
        }
    }
}

#Preview {
    MedicalRecordCard(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()),
                      medicalRecord: getMedicalRecords()[0])
}
