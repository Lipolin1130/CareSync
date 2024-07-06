//
//  MedicineInfoListCard.swift
//  CareSync
//
//  Created by Mac on 2024/7/6.
//

import SwiftUI

struct MedicineInfoListCard: View {
    var medicineNotify: MedicineNotify
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectMedicineNotify: MedicineNotify?
    
    var body: some View {
        
        Button {
            self.selectMedicineNotify = medicineNotify
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Image(systemName: "pills")
                    
                    Text(medicineNotify.medicine.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Total: \(medicineNotify.completeDoses) / \(medicineNotify.medicationDose.count)")
                        .font(.callout)
                }
                .foregroundStyle(.black)
                
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 290, height: 1)
                    .foregroundStyle(medicineNotify.person.color)
                    .padding(.bottom, 5)
                
                HStack {
                    Text("\(medicineNotify.startDate.toString())")
                        .foregroundStyle(.red)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text("\(medicineNotify.startDate.adding(day: medicineNotify.duration).toString())")
                        .foregroundStyle(.black)
                }
                .font(.headline)
                .italic()
                
                HStack {
                    Text(medicineNotify.eatTimeDescription)
                        .foregroundStyle(.black)
                        .font(.callout)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(width: 300, height: 150)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 2)
                .stroke(medicineNotify.person.color, lineWidth: 2)
        )
    }
}

#Preview {
    MedicineInfoListCard(
        medicineNotify: MedicineInfoViewModel(persons: getPersons()).medicineNotify[0], selectMedicineNotify: .constant(MedicineInfoViewModel(persons: getPersons()).medicineNotify[0])
    )
}
