//
//  MedicalRecordView.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordView: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @ObservedObject var calendarInfoViewModel: CalendarInfoViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(medicalRecordViewModel.filteredRecords.sorted(by: {
                        $0.date > $1.date})) {record in
                            MedicalRecordCard(medicalRecordViewModel: medicalRecordViewModel, medicalRecord: record)
                        }
                }
                .padding(.vertical, 40)
                .navigationTitle("MedicalRecord")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink {
                            MedicalRecordAddView(calendarInfoViewModel: calendarInfoViewModel,
                                                 medicalRecordViewModel: medicalRecordViewModel)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker(selection: $medicalRecordViewModel.personSelect) {
                                Text(allPerson.name).tag(0)
                                ForEach(medicalRecordViewModel.persons.indices, id: \.self) {index in
                                    Text(medicalRecordViewModel.persons[index].name).tag(index + 1)
                                }
                            } label: {
                                EmptyView()
                            }
                        } label: {
                            HStack {
                                Text(medicalRecordViewModel.selectedPerson.name)
                                Image(systemName: "chevron.down")
                            }
                        }
                        .font(.footnote)
                        .accentColor(medicalRecordViewModel.selectedPerson.color)
                        .onChange(of: medicalRecordViewModel.personSelect) { _, newValue in
                            medicalRecordViewModel.updateSelection(to: newValue)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalRecordView(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()), 
                          calendarInfoViewModel: CalendarInfoViewModel(persons: getPersons()))
    }
}
