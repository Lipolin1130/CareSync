//
//  MedicineInfoCard.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import SwiftUI

struct MedicineInfoList: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    var body: some View {
        LazyVStack(spacing: 20) {
            if let doses = medicineInfoViewModel.filterMedicationDose {
                if doses.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.green)
                        
                        Text("Today Has No Medicine!!")
                            .font(.title3)
                            .fontWeight(.black)
                    }
                    .offset(y: 100)
                    
                } else {
                    ForEach(doses) {dose in
                        MedicineInfoCard(medicationDose: dose)
                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
    }
}

#Preview {
    MedicineInfoList(medicineInfoViewModel: MedicineInfoViewModel(persons: getPersons()))
}


