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
    
    init() {
        _calendarInfoViewModel = StateObject(wrappedValue: CalendarInfoViewModel(persons: getPersons()))
    }
    
    var body: some View {
        ZStack {
            TabView (selection: $selectedTab) {
                CalendarInfoView(calendarInfoViewModel: calendarInfoViewModel,
                                 persons: $persons)
                                .tag(0)
                
                PersonDashboardView(persons: $persons)
                    .tag(1)
                
                Text("Third Page")
                    .tag(2)
                
                Text("Fourth Page")
                    .tag(3)
                
                Text("Fifth Page")
                    .tag(4)
            }
            .onChange(of: selectedTab) { oldValue, newValue in
                if newValue == 2 {
                    selectedTab = oldValue
                    calendarInfoViewModel.focusDate = YearMonthDay.current
                }
            }
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab, isSheetPresented: $addCalendarInfoSheet)
            }
        }
        .ignoresSafeArea(.all)
        .sheet(isPresented: $addCalendarInfoSheet) {
            AddCalendarInfoView(calendarInfoViewModel: calendarInfoViewModel,
                                addCalendarInfoSheet: $addCalendarInfoSheet)
        }
    }
}

#Preview {
    HomeView()
}
