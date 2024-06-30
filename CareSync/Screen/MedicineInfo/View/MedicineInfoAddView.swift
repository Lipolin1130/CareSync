//
//  MedicineInfoAddView.swift
//  CareSync
//
//  Created by Mac on 2024/6/29.
//

import SwiftUI

struct MedicineInfoAddView: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    @State var personSelect: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Choose Member", selection: $personSelect) {
                        ForEach(medicineInfoViewModel.persons.indices, id: \.self) {index in
                            Text(medicineInfoViewModel.persons[index].name).tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(medicineInfoViewModel.persons[personSelect].color)
                    .onChange(of: personSelect) { _, _ in
                        medicineInfoViewModel.addMedicineInfo.person = medicineInfoViewModel.persons[personSelect]
                    }
                } header: {
                    Text("Person")
                }
                
                Section {
                    TextField("Medicine Name", text: $medicineInfoViewModel.addMedicineInfo.medicine.name)
                    TextField("(Optional) Appearance", text: $medicineInfoViewModel.addMedicineInfo.medicine.appearance)
                    TextField("(Optional) Instructions", text: $medicineInfoViewModel.addMedicineInfo.medicine.instructions)
                    TextField("(Optional) Precautions", text: $medicineInfoViewModel.addMedicineInfo.medicine.precautions)
                    TextField("(Optional) SideEffect", text: $medicineInfoViewModel.addMedicineInfo.medicine.sideEffect)
                } header: {
                    HStack {
                        Text("Medicine Information")
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "camera.viewfinder")
                                .font(.title2)
                        }
                    }
                } footer: {
                    Text("Please input the Medicine Name")
                }
                
                Section {
                    DatePicker("StartTime", selection: $medicineInfoViewModel.addMedicineInfo.startDate)
                        .datePickerStyle(.compact)
                    
                    Picker("Interval Days", selection: $medicineInfoViewModel.addMedicineInfo.intervalDays) {
                        ForEach(1...7, id: \.self) {day in
                            Text("\(day) days")
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Duration", selection: $medicineInfoViewModel.addMedicineInfo.duration) {
                        ForEach(3...30, id: \.self) {day in
                            Text("\(day) days")
                        }
                    }
                    .pickerStyle(.menu)
                    
                    NavigationLink {
                        MultiSelectPicker(items: MealTime.allCases, selections: $medicineInfoViewModel.addMedicineInfo.eatTime)
                    } label: {
                        Text("Medicine Time")
                    }
                } header: {
                    HStack {
                        
                        Text("Medicine Use")
                        
                        Spacer()
                        
                        Button {
                            hideKeyboard()
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                } footer: {
                    Text("StartTime is you get the medicine time ")
                }
                
                Section {
                    Toggle(isOn: $medicineInfoViewModel.addMedicineInfo.notify) {
                        Text("Notify")
                    }
                } header: {
                    Text("Notify")
                }
            }
            .headerProminence(.increased)
            .navigationTitle("Add Medicine")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        medicineInfoViewModel.addNewMedicineNotify()
                    } label: {
                        Text("Done")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        medicineInfoViewModel.addMedicineInfoSheet.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicineInfoAddView(medicineInfoViewModel: MedicineInfoViewModel(persons: getPersons()))
    }
}
