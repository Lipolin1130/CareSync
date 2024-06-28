//
//  MedicineInfoCard.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import SwiftUI

struct MedicineInfoCard: View {
    @ObservedObject var medicationDose: MedicationDose
    var body: some View {
        HStack {
            VStack(spacing: 10) {
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(0.8)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("\(medicationDose.medicineName)")
                            .font(.title2.bold())
                        
                        Text("\(medicationDose.person.name)")
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    VStack(alignment: .center, spacing: 12) {
                        Text("\(medicationDose.time.formatted(date: .omitted, time: .shortened))")
                        
                        Button {
                            withAnimation {
                                medicationDose.complete.toggle()
                            }
                        } label: {
                            Image(systemName: medicationDose.complete ? "checkmark.square" : "square")
                                .font(.title)
                        }
                    }
                }
            }
            .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 46/255))
            .padding(.bottom, 10)
            .padding(15)
            .background(medicationDose.person.color.opacity(0.4).cornerRadius(25))
        }
        .padding(.horizontal)
        .hLeading()
    }
}

#Preview {
    MedicineInfoCard(medicationDose: MedicationDose(time: Date(), person: MockPersonData.mother.person, medicineName: MockMedicineData.aspirin.medicine.name ))
}
