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
}

#Preview {
    NavigationStack {
        PersonHealthView(persons: .constant(getPersons()))
    }
}
