//
//  MedicalRecordCard.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordCard: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @ObservedObject var medicalRecord: MedicalRecord
    
    var body: some View {
        NavigationLink {
            MedicalRecordDetailView(medicalRecordViewModel: medicalRecordViewModel,
                                    medicalRecord: medicalRecord)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text(String(medicalRecord.date.year))
                        .font(.caption)
                    
                    Spacer()
                    
                    Text(medicalRecord.person.name)
                        .padding(3)
                        .font(.subheadline)
                        .background(.white)
                        .bold()
                        .foregroundStyle(medicalRecord.person.color)
                        .cornerRadius(8)
                }
                
                HStack {
                    Text("\(medicalRecord.date.toYearMonthDay().toWeekString())")
                        .font(.title3)
                        .fontWeight(.bold)
                        
                    Text("\(medicalRecord.date, style: .time)")
                        .padding(.leading, 10)
                        .font(.headline)
                }
                
                Text(medicalRecord.hospitalName)
                    .font(.subheadline)
                
                if medicalRecord.appointment {
                    Text("Appointment: \(medicalRecord.appointmentDay?.toYearMonthDay().toWeekString() ?? "")")
                        .font(.subheadline)
                        .italic()
                }
            }
            .padding(10)
            .frame(width: 350 ,height: 125, alignment: .topLeading)
            .foregroundStyle(.white)
            .background(medicalRecord.person.color.opacity(0.5))
            .cornerRadius(10)
        }
    }
}

#Preview {
    MedicalRecordCard(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()),
                      medicalRecord: getMedicalRecords()[0])
}
