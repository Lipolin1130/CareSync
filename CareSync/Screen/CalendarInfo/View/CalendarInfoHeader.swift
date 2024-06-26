//
//  InformationHeader.swift
//  CareSync
//
//  Created by Mac on 2024/6/11.
//

import SwiftUI

struct CalendarInfoHeader: View {
    @ObservedObject var calendarInfoViewModel: CalendarInfoViewModel
    @ObservedObject var calendarControll: CalendarController
    @Binding var personSelect: Int
    let persons: [Person]
    var onSelectChange: (Int) -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("\(String(calendarControll.yearMonth.year))")
                    .font(.caption)
                    .fontWeight(.semibold)
                Text("\(calendarControll.yearMonth.monthShortString)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Picker(selection: $personSelect) {
                Text(allPerson.name).tag(0)
                ForEach(persons.indices, id: \.self) {index in
                    Text(persons[index].name).tag(index + 1)
                }
            } label: {
                Text(calendarInfoViewModel.selectedPerson.name)
            }
            .font(.title2)
            .pickerStyle(.menu)
            .accentColor(calendarInfoViewModel.selectedPerson.color)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .foregroundColor(calendarInfoViewModel.selectedPerson.color)
            }
            .onChange(of: personSelect) { _, newValue in
                onSelectChange(newValue)
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    CalendarInfoHeader(calendarInfoViewModel: CalendarInfoViewModel(persons: getPersons()),
                       calendarControll: CalendarController(),
                       personSelect: .constant(2),
                       persons: getPersons(), 
                       onSelectChange: {_ in })
}
