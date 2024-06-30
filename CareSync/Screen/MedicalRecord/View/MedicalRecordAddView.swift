//
//  MedicalRecordAddView.swift
//  CareSync
//
//  Created by Mac on 2024/6/30.
//

import SwiftUI

struct MedicalRecordAddView: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @State var personSelect: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            
            Section {
                DatePicker("Date", selection: $medicalRecordViewModel.medicalRecordAdd.date)
            } header: {
                Text("Date")
            }
            Section {
                Picker("Choose Member", selection: $personSelect) {
                    ForEach(medicalRecordViewModel.persons.indices, id: \.self) {index in
                        Text(medicalRecordViewModel.persons[index].name).tag(index)
                    }
                }
                .pickerStyle(.menu)
                .accentColor(medicalRecordViewModel.persons[personSelect].color)
                .onChange(of: personSelect) { _, _ in
                    medicalRecordViewModel.medicalRecordAdd.person = medicalRecordViewModel.persons[personSelect]
                }
            } header: {
                Text("Person")
            }
            
            Section {
                
                TextField("Name", text: $medicalRecordViewModel.medicalRecordAdd.hospitalName)
                
                TextField("(Optional) Location", text: $medicalRecordViewModel.medicalRecordAdd.hospitalLocation)
            } header: {
                
                HStack {
                    Text("Hospital")
                    
                    Spacer()
                    
                    Button {
                        //TODO: Map View Selection
                    } label: {
                        Image(systemName: "map")
                            .font(.title3)
                    }
                }
            }
            
            Section {
                ZStack(alignment: .leading) {
                    if medicalRecordViewModel.medicalRecordAdd.symptomDescription.isEmpty {
                        VStack {
                            Text("(Optional) Symtom Description")
                                .padding(.top, 10)
                                .padding(.leading, 6)
                                .opacity(0.6)
                            Spacer()
                        }
                    }
                    TextEditor(text: $medicalRecordViewModel.medicalRecordAdd.symptomDescription).frame(minHeight: 80)
                    
                    Spacer()
                }
                
                ZStack(alignment: .leading) {
                    if medicalRecordViewModel.medicalRecordAdd.doctorOrder.isEmpty {
                        VStack {
                            Text("(Optional) Doctor Order")
                                .padding(.top, 10)
                                .padding(.leading, 6)
                                .opacity(0.6)
                            Spacer()
                        }
                        
                    }
                    TextEditor(text: $medicalRecordViewModel.medicalRecordAdd.doctorOrder).frame(minHeight: 80)
                    
                    Spacer()
                }
                
            } header: {
                HStack {
                    
                    Text("symptom")
                    
                    Spacer()
                    
                    Button {
                        //TODO: Open AI translate
                    } label: {
                        
                        Text("AI Help")
                            .font(.callout.bold())
                            .foregroundStyle(.purple)
                        
                        Image(systemName: "sparkles")
                            .font(.title3)
                            .foregroundStyle(.purple)
                    }
                }
            }
            
            Section {
                Toggle(isOn: $medicalRecordViewModel.medicalRecordAdd.appointment) {
                    Text("Appointment")
                }
                
                if medicalRecordViewModel.medicalRecordAdd.appointment {
                    DatePicker("Date", selection: $medicalRecordViewModel.medicalRecordAdd.appointmentDay.toNonOptional(defaultValue: medicalRecordViewModel.medicalRecordAdd.date.adding(day: 7)))
                }
                
            } header: {
                Text("Appointment")
            }
        }
        .headerProminence(.increased)
        .navigationTitle("Add MedicalRecord")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    medicalRecordViewModel.addMedicalRecords()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalRecordAddView(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()))
    }
}
