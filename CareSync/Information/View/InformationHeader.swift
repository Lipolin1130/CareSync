//
//  InformationHeader.swift
//  CareSync
//
//  Created by Mac on 2024/6/11.
//

import SwiftUI
import SwiftUICalendar

struct InformationHeader: View {
    @ObservedObject var calendarControll: CalendarController
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button("Prev") {
                calendarControll.scrollTo(calendarControll.yearMonth.addMonth(value: -1), isAnimate: true)
            }
            .padding(8)
            
            Spacer()
            Text("\(calendarControll.yearMonth.monthShortString), \(String(calendarControll.yearMonth.year))")
                .font(.title2)
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            Spacer()
    
            Button("Next") {
                calendarControll.scrollTo(calendarControll.yearMonth.addMonth(value: 1), isAnimate: true)
            }
            .padding(8)
        }
    }
}

#Preview {
    InformationHeader(calendarControll: CalendarController())
}
