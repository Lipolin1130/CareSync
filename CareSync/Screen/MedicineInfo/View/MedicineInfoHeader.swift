//
//  MedicineInfoHeader.swift
//  CareSync
//
//  Created by Mac on 2024/6/28.
//

import SwiftUI

struct MedicineInfoHeader: View {
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(.white)
    }
}

#Preview {
    MedicineInfoHeader()
}
