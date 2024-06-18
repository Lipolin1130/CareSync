//
//  InformationHeader.swift
//  CareSync
//
//  Created by Mac on 2024/6/11.
//

import SwiftUI

struct CalendarInfoHeader: View {
    @ObservedObject var calendarControll: CalendarController
    @Binding var pickerSelect: Int
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
            
            Picker(persons[pickerSelect].name, selection: $pickerSelect) {
                ForEach(persons.indices, id: \.self) {index in
                    Text(persons[index].name).tag(index)
                }
            }
            .font(.title2)
            .pickerStyle(.menu)
            .accentColor(persons[pickerSelect].color)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .foregroundColor(persons[pickerSelect].color)
            }
            .onChange(of: pickerSelect) { _, newValue in
                onSelectChange(newValue)
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    CalendarInfoHeader(calendarControll: CalendarController(),
                       pickerSelect: .constant(2), 
                       persons: getPersons(), 
                       onSelectChange: {_ in })
}
