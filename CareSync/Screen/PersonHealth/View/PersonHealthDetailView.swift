//
//  PersonDashboard.swift
//  CareSync
//
//  Created by Mac on 2024/6/15.
//

import SwiftUI

struct PersonHealthDetailView: View {
    var person: Person
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        HStack(alignment: .center) {
                            Text("Date of Birth")
                            Spacer()
                            Text(person.birthDate.toString())
                        }
                        
                        SectionView(title: "Blood Type", describe: person.bloodType)
                        SectionView(title: "Sex", describe: person.gender ? "Male" : "Female")
                        
                        HStack {
                            Text("Color")
                            Spacer()
                            Circle()
                                .foregroundStyle(person.color)
                                .frame(width: 20, height: 20)
                        }
                    } header: {
                        HStack{
                            Spacer()
                            VStack(alignment: .center) {
                                Image(person.imageName)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                
                                Text(person.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(person.color)
                                
                                Text("Age: \(person.age, specifier: "%.0f")")
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                                
                            }
                            .textCase(.none)
                            
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    
                    Section {
                        GroupBox {
                            VStack(alignment: .center, spacing: 5) {
                                HStack {
                                    Text("\(person.height, specifier: "%.2f") cm")
                                    
                                    Spacer()
                                    
                                    Text("\(person.weight, specifier: "%.2f") kg")
                                }
                                .padding(.horizontal, 30)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    
                                    Text("BMI: \(person.bmi, specifier: "%.2f")")
                                    
                                    Spacer()
                                    
                                    Text(person.bmiDescription)
                                }
                                .padding(.horizontal, 30)
                                .padding(.bottom, 10)
                                .fontWeight(.semibold)
                                .font(.headline)
                                .foregroundStyle(person.bmiColor)
                            }
                        } label: {
                            Label("Body", systemImage: "figure")
                                .foregroundStyle(.blue)
                        }
                        .groupBoxStyle(.personHealth())
                    }  // BMI
                    
                    Section {
                        GroupBox {
                            VStack(alignment: .center) {
                                ForEach(person.medicalFamily, id: \.self) {medicalFamily in
                                    HStack(alignment: .center, spacing: 10) {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.red)
                                        Text(medicalFamily)
                                    }
                                }
                            }
                            .padding(.leading, 30)
                        } label: {
                            Label("Family Medical History", systemImage: "heart.fill")
                                .foregroundStyle(.red)
                            
                        }
                        .groupBoxStyle(.personHealth())
                    }
                    
                    Section {
                        GroupBox {
                            VStack(alignment: .center) {
                                ForEach(person.medicalHistory, id: \.self) {medicalHistory in
                                    HStack(alignment: .center, spacing: 10) {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.orange)
                                        Text(medicalHistory)
                                    }
                                }
                            }
                            .padding(.leading, 30)
                        } label: {
                            Label("MedicalHistory", systemImage: "scroll.fill")
                                .foregroundStyle(.orange)
                            
                        }
                        .groupBoxStyle(.personHealth())
                    }
                    
                    Section {
                        GroupBox {
                            VStack(alignment: .center) {
                                ForEach(person.allergy, id: \.self) {allergy in
                                    HStack(alignment: .center, spacing: 10) {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.green)
                                        Text(allergy)
                                    }
                                }
                            }
                            .padding(.leading, 30)
                        } label: {
                            Label("Allergy", systemImage: "allergens.fill")
                                .foregroundStyle(.green)
                            
                        }
                        .groupBoxStyle(.personHealth())
                    }
                    
                    Section {
                        GroupBox {
                            VStack(alignment: .center) {
                                ForEach(person.drugAllergy, id: \.self) {drugAllergey in
                                    HStack(alignment: .center, spacing: 10) {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.purple)
                                        
                                        Text(drugAllergey)
                                    }
                                }
                            }
                            .padding(.leading, 30)
                        } label: {
                            Label("Drug Allergy", systemImage: "pills.circle")
                                .foregroundStyle(.purple)
                        }
                        .groupBoxStyle(.personHealth())
                    }
                }
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 10)
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

struct SectionView: View {
    var title: String
    var describe: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(describe)
        }
    }
}

#Preview {
    NavigationStack {
        PersonHealthDetailView(person: getPersons()[0])
    }
}
