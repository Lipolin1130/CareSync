//
//  MedicalRecordDetailView.swift
//  CareSync
//
//  Created by Mac on 2024/6/21.
//

import SwiftUI

struct MedicalRecordDetailView: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @State var editButtonPress: Bool = false
    let selectIndex: Int
    
    var medicalRecord: MedicalRecord {
        medicalRecordViewModel.sortedMedicalRecords[selectIndex]
    }
    
    var body: some View {
            
            VStack(alignment: .leading) {
                
                GroupBox {
                    Text("\(medicalRecord.yearMonthDay.toWeekString())")
                } label: {
                    Label("Date", systemImage: "building.columns")
                }

                GroupBox {
                    
                } label: {
                    //Person
                    Label("Person", systemImage: "building.columns")
                }
                
                GroupBox {
                    
                } label: {
                    // Hospital
                    // Hospital location
                    Label("Hospital", systemImage: "cross.case.fill")
                }
                
                GroupBox {
                    //symptomDescription
                } label: {
                    Label("symptomDescription", systemImage: "list.clipboard.fill")
                }
                GroupBox {
                    // doctorOrder
                } label: {
                    Label("doctorOrder", systemImage: "building.columns")
                }
                
                GroupBox {
                    
                } label: {
                    Label("Appointment", systemImage: "building.columns")
                    
                }
            .toolbar {
                ToolbarItem {
                    Button {
                        editButtonPress.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalRecordDetailView(medicalRecordViewModel: MedicalRecordViewModel(),
                                selectIndex: 0)
    }
}
