//
//  MedicalRecordView.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordView: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(medicalRecordViewModel.sortedMedicalRecords.indices, id: \.self) { index in
                        MedicalRecordCard(medicalRecordViewModel: medicalRecordViewModel, selectIndex: index)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    //TODO: jump to MedicalRecordDetailView
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    MedicalRecordView(medicalRecordViewModel: MedicalRecordViewModel())
}
