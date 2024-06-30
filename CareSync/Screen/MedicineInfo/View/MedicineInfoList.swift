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
                    Text("No tasks found!!")
                        .font(.system(size: 16))
                        .fontWeight(.light)
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


