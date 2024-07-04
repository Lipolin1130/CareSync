//
//  CustomProgressView.swift
//  CareSync
//
//  Created by Mac on 2024/7/4.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing).opacity(0.3)
                .edgesIgnoringSafeArea(.bottom)
            
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing))
                .scaleEffect(1.5)
        }
    }
}

#Preview {
    CustomProgressView()
}
