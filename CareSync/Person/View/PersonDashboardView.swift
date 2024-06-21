//
//  PersonDashboard.swift
//  CareSync
//
//  Created by Mac on 2024/6/15.
//

import SwiftUI

struct PersonDashboardView: View {
    @Binding var persons: [Person]
    
    var body: some View {
        VStack {
            ForEach(persons) {person in
                Text(person.name)
                    .foregroundColor(person.color)
            }
        }
    }
}

#Preview {
    PersonDashboardView(persons: .constant(getPersons()))
}
