//
//  MedicineInfoCard.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import SwiftUI

struct MedicineInfoCard: View {
    @ObservedObject var medicationDose: MedicationDose
    @State private var isCompleteButtonPress = false
    
    var body: some View {
        HStack {
            VStack(spacing: 10) {
                Circle()
                    .fill(medicationDose.complete ? medicationDose.person.color : .clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(medicationDose.complete ? 0.8 : 1)
                
                Rectangle()
                    .fill(medicationDose.person.color)
                    .frame(width: 3)
            }
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("\(medicationDose.medicineName)")
                            .font(.title2.bold())
                        if !medicationDose.complete {
                            Text("\(medicationDose.person.name)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .hLeading()
                    
                    VStack(alignment: .center, spacing: 12) {
                        Text("\(medicationDose.time.formatted(date: .omitted, time: .shortened))")
                        
                        if !isCompleteButtonPress {
                            Button {
                                withAnimation {
                                    isCompleteButtonPress = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        medicationDose.complete = true
                                    }
                                }
                            } label: {
                                Image(systemName: isCompleteButtonPress ? "checkmark.square" : "square")
                                    .font(.title)
                            }
                        }
                    }
                }
            }
            .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 46/255))
            .padding(15)
            .padding(.bottom, medicationDose.complete ? 0 : 15)
            .hLeading()
            .background(medicationDose.person.color.opacity(0.4).cornerRadius(25))
        }
        .padding(.horizontal)
        .hLeading()
    }
}

#Preview {
    MedicineInfoCard(medicationDose: MedicationDose(time: Date(), person: MockPersonData.mother.person, medicineName: MockMedicineData.aspirin.medicine.name ))
}
