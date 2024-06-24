//
//  HomeView.swift
//  CareSync
//
//  Created by Mac on 2024/6/9.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab: Int = 0
    @State var addCalendarInfoSheet: Bool = false
    @State var persons: [Person] = getPersons()
    @StateObject var calendarInfoViewModel: CalendarInfoViewModel
    @StateObject var medicalRecordViewModel: MedicalRecordViewModel
    
    init() {
        _calendarInfoViewModel = StateObject(wrappedValue: CalendarInfoViewModel(persons: getPersons()))
        _medicalRecordViewModel = StateObject(wrappedValue: MedicalRecordViewModel())
    }
    
    var body: some View {
        TabView (selection: $selectedTab) {
            CalendarInfoView(calendarInfoViewModel: calendarInfoViewModel,
                             persons: $persons)
                .tag(0)
                .tabItem {
                    Label("Calendar", systemImage: "calendar.badge.checkmark")
                }
            
            MedicalRecordView(medicalRecordViewModel: medicalRecordViewModel,
                              persons: $persons)
                .tag(1)
                .tabItem {
                    Label("Dashboard", systemImage: "list.bullet.clipboard")
                }
            
            Text("Third Page")
                .tag(2)
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }
            
            Text("Fourth Page")
                .tag(3)
                .tabItem {
                    Label("Pills", systemImage: "pills.fill")
                }
            
            Text("Fifth Page")
                .tag(4)
                .tabItem {
                    Label("Daily", systemImage: "waveform.path.ecg")
                }
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == 2 {
                self.addCalendarInfoSheet = true
                calendarInfoViewModel.focusDate = YearMonthDay.current
                selectedTab = oldValue
            }
        }
        .sheet(isPresented: $addCalendarInfoSheet) {
            AddCalendarInfoView(calendarInfoViewModel: calendarInfoViewModel,
                                addCalendarInfoSheet: $addCalendarInfoSheet)
        }
    }
}

#Preview {
    HomeView()
}
