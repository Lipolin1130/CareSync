//
//  MedicineInfoListView.swift
//  CareSync
//
//  Created by Mac on 2024/7/6.
//

import SwiftUI

struct MedicineInfoListView: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectMedicineNotify: MedicineNotify
    let person: Person
    var body: some View {
        VStack {
            ForEach(medicineInfoViewModel.medicineNotify.filter {$0.person.name == person.name }) {medicineNotify in
                MedicineInfoListCard(medicineNotify: medicineNotify,
                                     selectMedicineNotify: $selectMedicineNotify)
                .padding(.top, 10)
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    MedicineInfoListView(medicineInfoViewModel: MedicineInfoViewModel(persons: getPersons()),
                         selectMedicineNotify: .constant(MedicineInfoViewModel(
                            persons: getPersons()).medicineNotify[0]),
                         person: getPersons()[0])
}
