//
//  AddCalendarInfoVIew.swift
//  CareSync
//
//  Created by Mac on 2024/6/19.
//

import SwiftUI

struct AddCalendarInfoView: View {
    @ObservedObject var calendarInfoViewModel: CalendarInfoViewModel
    @Binding var addCalendarInfoSheet: Bool
    @State var calendarInfo: CalendarInfo = CalendarInfo()
    @State var personSelect: Int = 0
    let focusDate: YearMonthDay?
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button {
                    addCalendarInfoSheet.toggle()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.blue)
                }
                
                Spacer()
                
                Button {
                    calendarInfoViewModel.addInfo(yearMonthDay: focusDate!, 
                                                  information: calendarInfo)
                    addCalendarInfoSheet.toggle()
                } label: {
                    Text("Done")
                        .foregroundStyle(.blue)
                }
            }
            
            TextField("Task Title", text: $calendarInfo.taskTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(20)
            
            List {
                VStack (spacing: 30) {
                    DatePicker("Time", selection: $calendarInfo.time)
                    
                    Picker("Choose Member", selection: $personSelect) {
                        ForEach(calendarInfoViewModel.persons.indices, id: \.self) {index in
                            Text(calendarInfoViewModel.persons[index].name).tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(calendarInfoViewModel.persons[personSelect].color)
                    .onChange(of: personSelect) { _, _ in
                        calendarInfo.person = calendarInfoViewModel.persons[personSelect]
                    }
                    
                    Toggle(isOn: $calendarInfo.notify) {
                        Text("Notify")
                    }
                }
            }
            .listStyle(.plain)
            .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    
    AddCalendarInfoView(calendarInfoViewModel: CalendarInfoViewModel(persons: getPersons()),
                        addCalendarInfoSheet: .constant(false),
                        focusDate: YearMonthDay(year: 2024, month: 6, day: 20))
}
