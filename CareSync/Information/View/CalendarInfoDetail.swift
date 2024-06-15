//
//  InformationDetailView.swift
//  CareSync
//
//  Created by Mac on 2024/6/12.
//

import SwiftUI

struct CalendarInfoDetail: View {
    @Binding var infoDetailSheet: Bool
    @ObservedObject var viewModel: CalendarInfoViewModel
    let focusDate: YearMonthDay
    
    var body: some View {
        VStack {
            InfoDetailHeader(focusDate: focusDate)
            
            if let items = viewModel.information[focusDate] {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    
                    HStack {
                        Rectangle()
                            .frame(width: 3, height: 25)
                            .foregroundColor(item.taskColor)
                            .padding(.trailing, 10)
                        
                        Text(item.taskTitle)
                            .font(.title2)
                        
                        Spacer()
                        
                        Button {
                            //TODO: Action for the button
                            viewModel.toggleAlert(for: focusDate, at: index)
                        } label: {
                            VStack(alignment: .center) {
                                Image(systemName: item.alert ? "bell.and.waves.left.and.right.fill": "bell.slash.fill")
                                    .foregroundColor(item.alert ? .red: .gray)
                            }
                            .frame(width: 50)
                        }
                    }
                    .padding()
                    .cornerRadius(10)
                }
            }
            Spacer()
        }
    }
}

struct InfoDetailHeader: View {
    var focusDate: YearMonthDay
    var body: some View {
        HStack {
            Text("\(focusDate.month) 月 \(focusDate.day) 日 \(focusDate.dayOfWeek.longString(locale: Locale(identifier: "zh_CN")))")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                //TODO: Add the tasks in the
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
        .padding(20)
    }
}

#Preview {
    CalendarInfoDetail(
        infoDetailSheet: .constant(false),
        viewModel: CalendarInfoViewModel() ,
        focusDate: YearMonthDay(year: 2024, month: 6, day: 14))
}
