//
//  InformationDetailView.swift
//  CareSync
//
//  Created by Mac on 2024/6/12.
//

import SwiftUI

struct CalendarInfoDetail: View {
    @Binding var infoDetailSheet: Bool
    @State var addCalendarInfoSheet: Bool = false
    @ObservedObject var calendarInfoViewModel: CalendarInfoViewModel
    
    var body: some View {
        VStack {
            InfoDetailHeader(addCalendarInfoSheet: $addCalendarInfoSheet,
                             viewModel: calendarInfoViewModel)
            
            if let items = calendarInfoViewModel.informations[calendarInfoViewModel.focusDate] {
                List {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        
                        HStack(alignment: .center) {
                            
                            Text(item.time, style: .time)
                                .font(.caption2)
                                .frame(width: 55, alignment: .trailing)
                            
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 3, height: 25)
                                .foregroundColor(item.taskColor)
                            
                            Text(item.taskTitle)
                                .font(.title3)
                            
                            Spacer()
                            
                            
                            VStack(alignment: .center) {
                                Image(systemName: item.notify ? "bell.and.waves.left.and.right.fill": "bell.slash.fill")
                                    .foregroundColor(item.notify ? .red: .gray)
                            }
                            .frame(width: 50)
                            .onTapGesture {
                                withAnimation(.smooth) {
                                    calendarInfoViewModel.toggleNotify(for: calendarInfoViewModel.focusDate, at: index)
                                }
                            }
                        }
                        .padding(.vertical, 6)
                        .cornerRadius(10)
                        
                    }
                    .onDelete { indexSet in
                        if let index = indexSet.first {
                            let item = items[index]
                            calendarInfoViewModel.deleteInfo(yearMonthDay: calendarInfoViewModel.focusDate, id: item.id)
                        }
                    }
                }
                .listStyle(.plain)
            }
            Spacer()
        }
        .sheet(isPresented: $addCalendarInfoSheet) {
            AddCalendarInfoView(calendarInfoViewModel: calendarInfoViewModel,
                                addCalendarInfoSheet: $addCalendarInfoSheet)
        }
    }
}

struct InfoDetailHeader: View {
    @Binding var addCalendarInfoSheet: Bool
    @ObservedObject var viewModel: CalendarInfoViewModel
    
    var body: some View {
        HStack {
            
            Text(viewModel.focusDate.toWeekString())
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                addCalendarInfoSheet.toggle()
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
        calendarInfoViewModel: CalendarInfoViewModel(persons: getPersons()))
}
