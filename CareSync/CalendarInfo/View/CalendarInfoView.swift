//
//  CalendarView.swift
//  CareSync
//
//  Created by Mac on 2024/6/10.
//

import SwiftUI

struct CalendarInfoView: View {
    @ObservedObject var viewModel: CalendarInfoViewModel
    @ObservedObject var calendarControll: CalendarController = CalendarController()
    @State var focusDate: YearMonthDay? = YearMonthDay.current
    @State var infoDetailSheet: Bool = false
    @Binding var persons: [Person]
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                CalendarInfoHeader(calendarControll: calendarControll,
                                   pickerSelect: $viewModel.pickerSelect,
                                   persons: persons, 
                                   onSelectChange: viewModel.updatePickerSelection)
                
                CalendarView(calendarControll, header: { week in
                    GeometryReader { geometry in
                        Text(week.shortString)
                            .font(.subheadline)
                            .frame(width: geometry.size.width, 
                                   height: geometry.size.height,
                                   alignment: .center)
                    }
                }, component: { date in
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 2) {
                            
                            dayText(date)
                            
                            if let infos = viewModel.filteredInformation[date]{
                                ForEach(infos.indices, id: \.self) { index in
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
                        .frame(width: geometry.size.width, 
                               height: geometry.size.height,
                               alignment: .topLeading)
                        .border(.green.opacity(0.8), 
                                width: (focusDate == date ? 1 : 0))
                        .cornerRadius(2)
                        .contentShape(Rectangle())
                        .sheet(isPresented: $infoDetailSheet, content: {
                            if let focusDate = focusDate {
                                
                                CalendarInfoDetail(
                                    infoDetailSheet: $infoDetailSheet,
                                    viewModel: viewModel,
                                    focusDate: focusDate)
                            }
                        })
                        .onTapGesture {
                            withAnimation {
                                if focusDate == date {
                                    infoDetailSheet.toggle()
                                } else {
                                    focusDate = date
                                }
                            }
                        }
                    }
                })
            }
        }
    }
    
    private func dayText(_ date: YearMonthDay) -> some View {
        let text = Text("\(date.day)")
                .padding(4)

            if date.isToday {
                return text
                    .font(.system(size: 10, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .background(Color.red.opacity(0.95))
                    .cornerRadius(14)
                    .eraseToAnyView()
            } else {
                return text
                    .font(.system(size: 10, weight: .light, design: .default))
                    .opacity(date.isFocusYearMonth! ? 1 : 0.4)
                    .foregroundColor(getColor(date))
                    .contentShape(Rectangle())
                    .eraseToAnyView()
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

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

#Preview {
    CalendarInfoView(viewModel: CalendarInfoViewModel(persons: getPersons()),
                     persons: .constant(getPersons()))
}

