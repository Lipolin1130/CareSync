//
//  MedicineInfoAddView.swift
//  CareSync
//
//  Created by Mac on 2024/6/29.
//

import SwiftUI

struct MedicineInfoAddView: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    @StateObject var backendService: BackendService = BackendService()
    @State var personSelect: Int = 0
    @State var easyMedicineToggle: Bool = false
    @State var scannerSheet: Bool = false
    @State var scannerText: String = ""
    @State private var isLoading: Bool = false
    @State var addAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                        Toggle(isOn: $easyMedicineToggle) {
                            Text("Simple Medicine")
                        }
                        
                        TextField("Medicine Name", text: $medicineInfoViewModel.addMedicineInfo.medicine.name)
                        
                        if !easyMedicineToggle {
                            TextField("Appearance  (Optional)", text: $medicineInfoViewModel.addMedicineInfo.medicine.appearance)
                            TextField("Instructions  (Optional)", text: $medicineInfoViewModel.addMedicineInfo.medicine.instructions)
                            TextField("Precautions  (Optional)", text: $medicineInfoViewModel.addMedicineInfo.medicine.precautions)
                            TextField("SideEffect  (Optional)", text: $medicineInfoViewModel.addMedicineInfo.medicine.sideEffect)
                        }
                        
                    } header: {
                        HStack {
                            Text("Medicine Information")
                            
                            if !easyMedicineToggle {
                                
                                Spacer()
                                
                                Button {
                                    withAnimation(.spring(.smooth, blendDuration: 1)){
                                        scannerSheet.toggle()
                                    }
                                } label: {
                                    Image(systemName: "camera.viewfinder")
                                        .font(.title2)
                                }
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
                            HStack {
                                Text("Medicine Time")
                                
                                Spacer()
                                
                                Text("\(medicineInfoViewModel.eatTimeDescription)")
                                    .opacity(0.6)
                                    .font(.footnote)
                            }
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
                
                if isLoading {
                    CustomProgressView()
                }
            }
            .headerProminence(.increased)
            .navigationTitle("Add Medicine")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        addAlert.toggle()
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
            .sheet(isPresented: $scannerSheet) {
                self.makeScannerView()
            }
            .alert("Check All Information is Done", isPresented: $addAlert) {
                Button("Add", role: .destructive) {
                    medicineInfoViewModel.addNewMedicineNotify()
                }
                Button("Cancel", role: .cancel) {
                    addAlert.toggle()
                }
            }
        }
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: { textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                self.scannerText = outputText
                
                isLoading = true
                
                backendService.getMedicineInfo(prescription: self.scannerText) { result in
                    switch result {
                    case .success(let response):
                        print("Medicine Info Success: \(response)")
                        
                        DispatchQueue.main.async {
                            self.medicineInfoViewModel.addMedicineInfo.medicine = response.medicine
                            self.medicineInfoViewModel.addMedicineInfo.duration = response.duration
                            
                            self.medicineInfoViewModel.addMedicineInfo.intervalDays = response.intervalDays
                            self.medicineInfoViewModel.addMedicineInfo.eatTime = response.eatTime
                            self.medicineInfoViewModel.addMedicineInfo.objectWillChange.send()
                            
                            isLoading = false
                        }
                    case .failure(let error):
                        print("Medicine Info Error: \(error.localizedDescription)")
                    }
                }
            }
            self.scannerSheet = false
        })
    }
}

#Preview {
    NavigationStack {
        MedicineInfoAddView(medicineInfoViewModel: MedicineInfoViewModel(persons: getPersons()))
    }
}
