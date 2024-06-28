//
//  MedicineInfoWeek.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import SwiftUI

struct MedicineInfoWeek: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    @Namespace var animation
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(medicineInfoViewModel.currentWeek, id: \.self) {day in
                    VStack(spacing: 10) {
                        Text(medicineInfoViewModel.extractDate(date: day, format: "dd"))
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        
                        Text(medicineInfoViewModel.extractDate(date: day, format: "EEE"))
                            .font(.system(size: 14))
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 8, height: 8)
                            .opacity(medicineInfoViewModel.isToday(date: day) ? 1 : 0)
                    }
                    .foregroundStyle(medicineInfoViewModel.isToday(date: day) ? .primary : .tertiary)
                    .foregroundStyle(medicineInfoViewModel.isToday(date: day) ? .white : .black)
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack {
                            if medicineInfoViewModel.isToday(date: day) {
                                Capsule()
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                            }
                        }
                    )
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            medicineInfoViewModel.currentDay = day
                            medicineInfoViewModel.filterDose()
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    MedicineInfoWeek(medicineInfoViewModel: MedicineInfoViewModel())
}
