//
//  MedicalRecordView.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordView: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @Binding var persons: [Person]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(medicalRecordViewModel.sortedMedicalRecords.indices, id: \.self) { index in
                        MedicalRecordCard(medicalRecordViewModel: medicalRecordViewModel, selectIndex: index)
                    }
                }
            }
            .navigationTitle("MedicalRecord")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //TODO: jump to MedicalRecordDetailView
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalRecordView(medicalRecordViewModel: MedicalRecordViewModel(),
                          persons: .constant(getPersons()))
    }
}
