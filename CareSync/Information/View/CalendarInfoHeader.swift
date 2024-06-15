//
//  InformationHeader.swift
//  CareSync
//
//  Created by Mac on 2024/6/11.
//

import SwiftUI

struct CalendarInfoHeader: View {
    @ObservedObject var calendarControll: CalendarController
    
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
        }
    }
}

#Preview {
    CalendarInfoHeader(calendarControll: CalendarController())
}
