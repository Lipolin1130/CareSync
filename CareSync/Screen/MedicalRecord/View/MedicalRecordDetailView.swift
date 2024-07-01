//
//  MedicalRecordDetailView.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordDetailView: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @ObservedObject var medicalRecord: MedicalRecord
    @State var editButtonPress: Bool = false
    @State var selectPerson: Int
    
    init(medicalRecordViewModel: MedicalRecordViewModel, medicalRecord: MedicalRecord) {
        self.medicalRecordViewModel = medicalRecordViewModel
        self.medicalRecord = medicalRecord
        
        if let index = medicalRecordViewModel.persons.firstIndex (where: { $0.id == medicalRecord.person.id }) {
            self._selectPerson = State(initialValue: index)
        } else {
            self._selectPerson = State(initialValue: 0)
        }
    }
    
    var body: some View {
        ZStack {
            
            medicalRecord.person.color.opacity(0.3)
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center, spacing: 20) {
                    
                    GroupBox {
                        if editButtonPress {
                            DatePicker("", selection: $medicalRecord.date)
                                .padding(.trailing, 20)
                        } else {
                            HStack {
                                Text(medicalRecord.date, style: .date)
                                Text(medicalRecord.date, style: .time)
                            }
                            .padding(.trailing, 20)
                        }
                    } label: {
                        Label("Date", systemImage: "calendar")
                    }
                    
                    GroupBox {
                        if editButtonPress {
                            Picker(selection: $selectPerson) {
                                ForEach(medicalRecordViewModel.persons.indices, id: \.self) {index in
                                    Text(medicalRecordViewModel.persons[index].name).tag(index)
                                }
                            } label: {
                                EmptyView()
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 250, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        } else {
                            Text("\(medicalRecord.person.name)")
                        }
                    } label: {
                        Label("Person", systemImage: "person.fill")
                            .foregroundStyle(.blue)
                    }
                    .onChange(of: selectPerson) {_, newIndex in
                        medicalRecord.person = medicalRecordViewModel.persons[newIndex]
                    }
                    
                    GroupBox {
                        if editButtonPress {
                            TextField("", text: $medicalRecord.hospitalName)
                                .padding(.trailing, 15)
                                .textFieldStyle(.roundedBorder)
                            
                            TextField("Location", text: $medicalRecord.hospitalLocation)
                                .font(.footnote)
                                .padding(.trailing, 15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 15)
                            
                        } else {
                            Text("\(medicalRecord.hospitalName)")
                            
                            Text("\(medicalRecord.hospitalLocation)")
                                .font(.footnote)
                        }
                    } label: {
                        Label("Hospital", systemImage: "cross.case.fill")
                            .foregroundStyle(.red)
                    }
                    
                    GroupBox {
                        if editButtonPress {
                            TextEditor(text: $medicalRecord.symptomDescription)
                                .padding([.trailing, .bottom], 15)
                                .frame(minHeight: 150, alignment: .leading)
                        } else {
                            Text("\(medicalRecord.symptomDescription)")
                        }
                        
                    } label: {
                        Label("SymptomDescription", systemImage: "list.clipboard.fill")
                            .foregroundStyle(.orange)
                    }
                    
                    GroupBox {
                        if editButtonPress {
                            TextEditor(text: $medicalRecord.doctorOrder)
                                .padding([.trailing, .bottom], 15)
                                .frame(minHeight: 150, alignment: .leading)
                            
                        } else {
                            Text("\(medicalRecord.doctorOrder)")
                        }
                    } label: {
                        Label("DoctorOrder", systemImage: "heart.text.square.fill")
                            .foregroundStyle(.green)
                    }
                    
                    GroupBox {
                        if medicalRecord.appointment {
                            if editButtonPress {
                                DatePicker("", selection: $medicalRecord.appointmentDay.toNonOptional())
                                    .padding(.trailing, 20)
                            } else {
                                HStack {
                                    Text(medicalRecord.appointmentDay ?? Date(), style: .date)
                                    Text(medicalRecord.appointmentDay ?? Date(), style: .time)
                                }
                                .padding(.trailing, 20)
                            }
                        }
                    } label: {
                        HStack {
                            
                            Label("Appointment", systemImage: "calendar.badge.clock")
                                .foregroundStyle(.purple)
                            
                            if editButtonPress {
                                
                                Spacer()
                                
                                Toggle("", isOn: $medicalRecord.appointment)
                                    .tint(.purple)
                                    .scaleEffect(0.8)
                            }
                        }
                    }
                    .onChange(of: medicalRecord.appointment) {oldValue, newValue in
                        if newValue {
                            medicalRecord.appointmentDay = Date()
                        } else {
                            medicalRecord.appointmentDay = nil
                        }
                    }
                }
                .groupBoxStyle(.medicalRecord(centerOrLeading: editButtonPress))
                .padding(.vertical, 40)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        editButtonPress.toggle()
                    } label: {
                        Text(editButtonPress ? "Done" : "Edit")
                    }
                }
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        MedicalRecordDetailView(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()),                      medicalRecord: getMedicalRecords()[0])
    }
}
