//
//  CalendarView.swift
//  CareSync
//
//  Created by Mac on 2024/6/10.
//

import SwiftUI

struct CalendarInfoView: View {
    @State var informations = getInformation()
    
    @ObservedObject var calendarControll: CalendarController = CalendarController()
    @State var focusDate: YearMonthDay? = YearMonthDay.current
    @State var focusInfo: [CalendarInfo]? = nil
    @State var infoDetailSheet: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                InformationHeader(calendarControll: calendarControll)
                
                CalendarView(calendarControll, header: { week in
                    GeometryReader { geometry in
                        Text(week.shortString)
                            .font(.subheadline)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }, component: { date in
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 2) {
                            if date.isToday {
                                Text("\(date.day)")
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(Color.red.opacity(0.95))
                                    .cornerRadius(14)
                            } else {
                                Text("\(date.day)")
                                    .font(.system(size: 10, weight: .light, design: .default))
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                    .foregroundColor(getColor(date))
                                    .padding(4)
                                    .contentShape(Rectangle())
                                
                            }
                            
                            if let infos = informations[date] {
                                ForEach(infos.indices) { index in
                                    let info = infos[index]
                                    Text(info.taskTitle)
                                        .lineLimit(1)
                                        .foregroundColor(.white)
                                        .font(.system(size: 8, weight: .bold, design: .default))
                                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                        .frame(width: geometry.size.width, alignment: .center)
                                        .background(info.taskColor.opacity(0.75))
                                        .cornerRadius(4)
                                        .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                        .border(.green.opacity(0.8), width: (focusDate == date ? 1 : 0))
                        .cornerRadius(2)
                        .contentShape(Rectangle())
                        .sheet(isPresented: $infoDetailSheet, content: {
                            InformationDetailView(
                                infoDetailSheet: $infoDetailSheet,
                                information: $informations,
                                focusDate: focusDate!)
                        })
                        .onTapGesture {
                            withAnimation {
                                if focusDate == date {
                                    infoDetailSheet.toggle()
                                } else {
                                    focusDate = date
                                    focusInfo = informations[date]
                                }
                            }
                        }
                    }
                })
            }
        }
    }
    
    private func getColor(_ date: YearMonthDay) -> Color {
        if date.dayOfWeek == .sun {
            return Color.red
        } else if date.dayOfWeek == .sat {
            return Color.blue
        } else {
            return Color.black
        }
    }
}

#Preview {
    CalendarInfoView()
}

