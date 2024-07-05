//
//  PersonHealthView.swift
//  CareSync
//
//  Created by Mac on 2024/7/5.
//

import SwiftUI

struct PersonHealthView: View {
    @Binding var persons: [Person]
    var twoColumnGird = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: twoColumnGird) {
                    ForEach(persons) {person in
                        NavigationLink {
                            PersonHealthDetailView(person: person)
                        } label: {
                            VStack {
                                Image(person.imageName)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                
                                Text(person.name)
                                    .foregroundStyle(.black)
                                    .font(.headline)
                            }
                            .padding()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "plus")
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
