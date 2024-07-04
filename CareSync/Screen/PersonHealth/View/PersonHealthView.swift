//
//  PersonDashboard.swift
//  CareSync
//
//  Created by Mac on 2024/6/15.
//

import SwiftUI

struct PersonHealthView: View {
    @Binding var persons: [Person]
    @State var personSelect: Int = 0
    @StateObject var backendService: BackendService = BackendService()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Picker("Choose Member", selection: $personSelect) {
                        ForEach(persons.indices, id: \.self) {index in
                            Text(persons[index].name).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    VStack(spacing: 20) {
//                            Button("Fetch Medicine Info") {
//                                backendService.getMedicineInfo(prescription: getFakeMedicalInfo()) { result in
//                                    switch result {
//                                    case .success(let response):
//                                        print("Medicine Info Success: \(response)")
//                                    case .failure(let error):
//                                        print("Medicine Info Error: \(error.localizedDescription)")
//                                    }
//                                }
//                            }
                            
//                            Button("Fetch Record Summary") {
//                                if let fileURL = Bundle.main.url(forResource: "ttsmaker-file-2024-6-28-20-52-44", withExtension: "m4a") {
//                                    backendService.getRecordSummary(fileURL: fileURL) { result in
//                                        switch result {
//                                        case .success(let response):
//                                            print("Record Summary Success: \(response)")
//                                        case .failure(let error):
//                                            print("Record Summary Error: \(error.localizedDescription)")
//                                        }
//                                    }
//                                } else {
//                                    print("Audio file not found")
//                                }
//                            }
                        }
                        .padding()
                    }
                    Image(persons[personSelect].imageName)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //TODO: edit Personal age
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
        }
    }


#Preview {
    NavigationStack {
        PersonHealthView(persons: .constant(getPersons()))
    }
}
