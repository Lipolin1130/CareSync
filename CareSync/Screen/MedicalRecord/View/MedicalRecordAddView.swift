//
//  MedicalRecordAddView.swift
//  CareSync
//
//  Created by Mac on 2024/6/30.
//

import SwiftUI

struct MedicalRecordAddView: View {
    @ObservedObject var calendarInfoViewModel: CalendarInfoViewModel
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    @State var personSelect: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @State var medicalAISheet: Bool = false
    @StateObject var audioRecorder = AudioRecorder()
    @State private var isInitialized = false
    
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
                Text("Hospital")
            }
            
            Section {
                ZStack(alignment: .leading) {
                    if medicalRecordViewModel.medicalRecordAdd.symptomDescription.isEmpty {
                        VStack {
                            Text("(Optional) Symtom Description")
                                .foregroundStyle(.gray)
                                .padding(.top, 10)
                                .padding(.leading, 6)
                                .opacity(0.5)
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
                                .foregroundStyle(.gray)
                                .padding(.top, 10)
                                .padding(.leading, 6)
                                .opacity(0.5)
                            Spacer()
                        }
                    }
                    
                    TextEditor(text: $medicalRecordViewModel.medicalRecordAdd.doctorOrder).frame(minHeight: 80)
                    
                    Spacer()
                }
                
            } header: {
                HStack {
                    
                    Text("Symptom")
                    
                    Spacer()
                    
                    Button {
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    .padding(.trailing)
                    
                    Button {
                        medicalAISheet.toggle()
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
                Toggle("medicine", isOn: $medicalRecordViewModel.medicalRecordAdd.medicineCreate)
                
                if medicalRecordViewModel.medicalRecordAdd.medicineCreate {
                    NavigationLink {
                        MedicineInfoListView(
                            medicineInfoViewModel: medicineInfoViewModel,
                            selectMedicineNotify: $medicalRecordViewModel.medicalRecordAdd.medicineNotify,
                            person: medicalRecordViewModel.medicalRecordAdd.person)
                    } label: {
                        if let medicineNotify = medicalRecordViewModel.medicalRecordAdd.medicineNotify {
                            HStack {
                                Text("\(medicineNotify.medicine.name)")
                                
                                Spacer()
                                
                                Text("\(medicineNotify.startDate.toString())")
                            }
                        } else {
                            Text("Choose Medicine")
                        }
                    }
                }
            } header: {
                Text("Medicine")
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
                    if medicalRecordViewModel.medicalRecordAdd.appointment && medicalRecordViewModel.medicalRecordAdd.appointmentDay == nil {
                        medicalRecordViewModel.medicalRecordAdd.appointmentDay = medicalRecordViewModel.medicalRecordAdd.date.adding(day: 7)
                    }
                    
                    calendarInfoViewModel.addInfo(
                        yearMonthDay: medicalRecordViewModel.medicalRecordAdd.date.toYearMonthDay(),
                        information: CalendarInfo(
                            taskTitle: medicalRecordViewModel.medicalRecordAdd.person.name + "看診",
                            person: medicalRecordViewModel.medicalRecordAdd.person,
                            notify: false,
                            time: medicalRecordViewModel.medicalRecordAdd.date))
                    
                    if medicalRecordViewModel.medicalRecordAdd.appointment {
                        if let appointmentDay = medicalRecordViewModel.medicalRecordAdd.appointmentDay {
                            calendarInfoViewModel.addInfo(
                                yearMonthDay: appointmentDay.toYearMonthDay(),
                                information: CalendarInfo(
                                    taskTitle: medicalRecordViewModel.medicalRecordAdd.person.name + "回診",
                                    person: medicalRecordViewModel.medicalRecordAdd.person,
                                    notify: true,
                                    time: appointmentDay))
                        } else {
                            print("Appointment Day is nil")
                        }
                        
                    } else {
                        print("not appointment")
                    }
                    medicalRecordViewModel.addMedicalRecords()
                    
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
        .sheet(isPresented: $medicalAISheet) {
            MedicalRecordAddAISheetView(medicalRecordViewModel: medicalRecordViewModel,
                                        audioRecorder: audioRecorder,
                                        medicalAISheet: $medicalAISheet)
            .presentationDetents([.height(250)])
            .presentationDragIndicator(.hidden)
        }
        .onAppear {
            if !isInitialized {
                medicalRecordViewModel.medicalRecordAdd = MedicalRecord(person: getPersons()[0])
                isInitialized = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalRecordAddView(calendarInfoViewModel: CalendarInfoViewModel(persons: getPersons()),
                             medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()),
                             medicineInfoViewModel: MedicineInfoViewModel(persons: getPersons()))
    }
}
