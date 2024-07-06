//
//  MedicineInfoListView.swift
//  CareSync
//
//  Created by Mac on 2024/7/6.
//

import SwiftUI

struct MedicineInfoListView: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    @Binding var selectMedicineNotify: MedicineNotify?
    let person: Person
    
    var body: some View {
        ZStack {
            person.color.opacity(0.2)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(medicineInfoViewModel.medicineNotify.filter { $0.person.name == person.name }
                        .sorted(by: {$0.startDate > $1.startDate })) {medicineNotify in
                            
                            MedicineInfoListCard(medicineNotify: medicineNotify,
                                                 selectMedicineNotify: $selectMedicineNotify)
                            .padding(.top, 10)
                        }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    medicineInfoViewModel.addMedicineInfoSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Medicine List")
        .sheet(isPresented: $medicineInfoViewModel.addMedicineInfoSheet) {
            MedicineInfoAddView(medicineInfoViewModel: medicineInfoViewModel)
        }
    }
}

#Preview {
    NavigationStack {
        MedicineInfoListView(medicineInfoViewModel: MedicineInfoViewModel(persons: getPersons()),
                             selectMedicineNotify: .constant(MedicineInfoViewModel(
                                persons: getPersons()).medicineNotify[0]),
                             person: getPersons()[0])
    }
}
