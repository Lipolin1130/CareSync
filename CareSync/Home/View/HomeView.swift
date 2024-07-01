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
    @StateObject var medicineInfoViewModel: MedicineInfoViewModel
    
    init() {
        _calendarInfoViewModel = StateObject(wrappedValue: CalendarInfoViewModel(persons: getPersons()))
        _medicalRecordViewModel = StateObject(wrappedValue: MedicalRecordViewModel(persons: getPersons()))
        _medicineInfoViewModel = StateObject(wrappedValue: MedicineInfoViewModel(persons: getPersons()))
    }
    
    var body: some View {

        TabView (selection: $selectedTab) {
            CalendarInfoView(calendarInfoViewModel: calendarInfoViewModel)
                .tag(0)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            MedicalRecordView(medicalRecordViewModel: medicalRecordViewModel)
                .tag(1)
                .tabItem {
                    Label("Dashboard", systemImage: "stethoscope")
                }
            
            Text("Third Page")
                .tag(2)
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }
            
            MedicineInfoView(medicineInfoViewModel: medicineInfoViewModel)
                .tag(3)
                .tabItem {
                    Label("Medicine", systemImage: "pills")
                        .environment(\.symbolVariants, .none)
                }
            
            PersonHealthView(persons: $persons)
                .tag(4)
                .tabItem {
                    Label("Daily", systemImage: "pencil.and.list.clipboard")
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
