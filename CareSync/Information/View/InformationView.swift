//
//  CalendarView.swift
//  CareSync
//
//  Created by Mac on 2024/6/10.
//

import SwiftUI
import SwiftUICalendar
//
//struct CalendarView: View {
//    @State var currentDate: Date = Date()
//    @State var currentMonth: Int = 0
//    @State var tasks: [TaskMetaData] = [
//        TaskMetaData(task: [
//            Task(title: "回診", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//            Task(title: "吃藥", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//            Task(title: "MAIC", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//            Task(title: "ToDo", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//        ], taskDate: getSampleDate(offset: 1)),
//
//        TaskMetaData(task: [
//
//            Task(title: "Talk", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//
//        ], taskDate: getSampleDate(offset: -3)),
//
//        TaskMetaData(task: [
//
//            Task(title: "Meeting", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//        ], taskDate: getSampleDate(offset: 10)),
//
//        TaskMetaData(task: [
//
//            Task(title: "Project", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//        ], taskDate: getSampleDate(offset: -22)),
//
//        TaskMetaData(task: [
//
//            Task(title: "Homework", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//        ], taskDate: getSampleDate(offset: 15)),
//
//        TaskMetaData(task: [
//
//            Task(title: "Project", time: Date().addingTimeInterval(CGFloat.random(in: 0...5000))),
//        ], taskDate: getSampleDate(offset: -20)),
//
//    ]
//
//    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//    let columns = Array(repeating: GridItem(.flexible()), count: 7)
//
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack (spacing: 30) {
//
//                headerView
//
//                HStack {
//                    ForEach(days, id: \.self) {day in
//                        Text(day)
//                            .font(.callout)
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity)
//                    }
//                }
//
//                LazyVGrid(columns: columns, spacing: 10) {
//                    ForEach(extractDate()) { value in
//                        CalendarCardView(value: value, currentDate: currentDate, tasks: tasks)
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//
//    // MARK: - Header View
//    private var headerView: some View {
//
//        HStack(spacing: 20) {
//            VStack (alignment: .leading, spacing: 10) {
//
//                Text(monthYearString()[0])
//                    .font(.caption)
//                    .fontWeight(.semibold)
//
//                Text(monthYearString()[1])
//                    .font(.title.bold())
//            }
//
//            Spacer()
//
//            Button  {
//                withAnimation {
//                    currentMonth -= 1
//                }
//            } label: {
//                Image(systemName: "chevron.left")
//                    .font(.title2)
//            }
//
//            Button  {
//                withAnimation {
//                    currentMonth += 1
//                }
//            } label: {
//                Image(systemName: "chevron.right")
//                    .font(.title2)
//            }
//
//        }
//        .padding(.horizontal)
//    }
//
//    // MARK: - Date and Month Formatting
//    private func monthYearString() ->[String] {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY MMMM"
//
//        let date = formatter.string(from: getCurrentMonth())
//
//        return date.components(separatedBy: " ")
//    }
//
//    // MARK: - Current Month Calculation
//    private func getCurrentMonth() ->Date {
//        let calendar = Calendar.current
//
//        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
//            return Date()
//        }
//        return currentMonth
//    }
//
//    // MARK: - Extract Dates
//    private func extractDate() ->[DateValue] {
//        let calendar = Calendar.current
//        let currentMonth = getCurrentMonth()
//        var days =  currentMonth.getAllDates().compactMap { date -> DateValue in
//            let day = calendar.component(.day, from: date)
//            return DateValue(day: day, date: date)
//        }
//
//        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
//        for _ in 0..<firstWeekday - 1 {
//            days.insert(DateValue(day: -1, date: Date()), at: 0)
//        }
//        return days
//    }
//}

struct InformationView: View {
    var informations = [YearMonthDay: [(String, Color)]]()
    
    @ObservedObject var calendarControll: CalendarController = CalendarController()
    @State var focusDate: YearMonthDay? = YearMonthDay.current
    @State var focusInfo: [(String, Color)]? = nil
    
    init() {
        var date = YearMonthDay.current
        informations[date] = []
        informations[date]?.append(("Hello", Color.orange))
        informations[date]?.append(("World", Color.blue))
        
        date = date.addDay(value: 3)
        informations[date] = []
        informations[date]?.append(("Test", Color.pink))
        
        date = date.addDay(value: 8)
        informations[date] = []
        informations[date]?.append(("Jack", Color.green))
        
        date = date.addDay(value: 5)
        informations[date] = []
        informations[date]?.append(("Home", Color.red))
        
        date = date.addDay(value: -23)
        informations[date] = []
        informations[date]?.append(("Meet at 8, Home", Color.purple))
        
        date = date.addDay(value: -5)
        informations[date] = []
        informations[date]?.append(("Home", Color.yellow))
        
        date = date.addDay(value: -10)
        informations[date] = []
        informations[date]?.append(("Baseball", Color.green))
    }
    
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
                                    Text(info.0)
                                        .lineLimit(1)
                                        .foregroundColor(.white)
                                        .font(.system(size: 8, weight: .bold, design: .default))
                                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                        .frame(width: geometry.size.width, alignment: .center)
                                        .background(info.1.opacity(0.75))
                                        .cornerRadius(4)
                                        .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                        .border(.green.opacity(0.8), width: (focusDate == date ? 1 : 0))
                        .cornerRadius(2)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                if focusDate == date {
                                    focusDate = nil
                                    focusInfo = nil
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
    InformationView()
}

