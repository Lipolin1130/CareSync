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
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button {
                    addCalendarInfoSheet.toggle()
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
                
                Spacer()
                
                Button {
                    
                    calendarInfoViewModel.addInfo(yearMonthDay: calendarInfo.getYearMonthDay(),
                                                  information: calendarInfo)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        addCalendarInfoSheet.toggle()
                    }
                } label: {
                    Text("Done")
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.bordered)
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
        .onAppear {
            calendarInfo.time = calendarInfoViewModel.focusDate.toDate()
        }
    }
}

#Preview {
    AddCalendarInfoView(calendarInfoViewModel: CalendarInfoViewModel(persons: getPersons()),
                        addCalendarInfoSheet: .constant(false))
}
