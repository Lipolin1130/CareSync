//
//  MedicineInfo.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import SwiftUI

struct MedicineInfoView: View {
    @ObservedObject var medicineInfoViewModel: MedicineInfoViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    MedicineInfoWeek(medicineInfoViewModel: medicineInfoViewModel)
                } header: {
                    MedicineInfoHeader()
                }
                
                MedicineInfoList(medicineInfoViewModel: medicineInfoViewModel)
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    MedicineInfoView(medicineInfoViewModel: MedicineInfoViewModel())
}
