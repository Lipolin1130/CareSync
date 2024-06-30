//
//  MedicineInfoHeader.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import SwiftUI

struct MedicineInfoHeader: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            
            Spacer()
            
            Button {
                medicineInfoViewModel.addMedicineInfoSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
            }
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(.white)
    }
}

#Preview {
    MedicineInfoHeader(medicineInfoViewModel: MedicineInfoViewModel(persons: getPersons()))
}
