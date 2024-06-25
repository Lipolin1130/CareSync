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
    
    var body: some View {
        ZStack {
            
            medicalRecord.person.color.opacity(0.3)
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    GroupBox {
                        Text("\(medicalRecord.yearMonthDay.toWeekString())")
                    } label: {
                        Label("Date", systemImage: "calendar")
                    }
                    
                    
                    GroupBox {
                        Text("\(medicalRecord.person.name)")
                    } label: {
                        Label("Person", systemImage: "person.fill")
                            .foregroundStyle(.blue)
                    }
                    
                    GroupBox {
                        Text("\(medicalRecord.hospitalName)")
                        Text("\(medicalRecord.hospitalLocation ?? "")")
                    } label: {
                        Label("Hospital", systemImage: "cross.case.fill")
                            .foregroundStyle(.red)
                    }
                    
                    GroupBox {
                        Text("\(medicalRecord.symptomDescription ?? "")")
                        
                    } label: {
                        Label("symptomDescription", systemImage: "list.clipboard.fill")
                            .foregroundStyle(.orange)
                    }
                    GroupBox {
                        Text("\(medicalRecord.doctorOrder ?? "")")
                    } label: {
                        Label("doctorOrder", systemImage: "heart.text.square.fill")
                            .foregroundStyle(.green)
                    }
                    
                    if medicalRecord.appointment {
                        GroupBox {
                            Text("\(medicalRecord.appointmentDay!.toWeekString())")
                        } label: {
                            Label("Appointment", systemImage: "calendar.badge.clock")
                                .foregroundStyle(.purple)
                        }
                    }
                }
                .groupBoxStyle(.medicalRecord)
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

struct MedicalRecordGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            configuration.label
                .bold()
                .fontDesign(.monospaced)
            
            configuration.content
                .padding(.leading, 30)
        }
        .padding([.leading, .top], 20)
        .frame(minHeight: 120, alignment: .top)
        .frame(width: 300, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

extension GroupBoxStyle where Self == MedicalRecordGroupBoxStyle {
    static var medicalRecord: MedicalRecordGroupBoxStyle { .init() }
}

#Preview {
    NavigationStack {
        MedicalRecordDetailView(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()),                      medicalRecord: getMedicalRecords()[0])
    }
}
