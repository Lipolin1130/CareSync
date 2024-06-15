//
//  CustomTabBar.swift
//  CareSync
//
//  Created by Mac on 2024/6/12.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @Binding var isSheetPresented: Bool
    
    private let tabItems: [(imageName: String, tabIndex: Int)] = [
        ("calendar.badge.checkmark", 0),
        ("plus", 1),
        ("plus", 2),
        ("plus", 3),
        ("plus", 4)
    ]
    
    var body: some View {
        HStack {
            ForEach(tabItems, id: \.tabIndex) { item in
                Button {
                    if item.tabIndex == 2 {
                        isSheetPresented = true
                    } else {
                        selectedTab = item.tabIndex
                    }
                } label: {
                    VStack {
                        Image(systemName: item.imageName)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                    .foregroundColor(selectedTab == item.tabIndex ? 
                        .blue : .gray)
                }
                
                if item.tabIndex != tabItems.last?.tabIndex {
                    Spacer()
                }
            }
        }
        .padding()
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0),
                 isSheetPresented: .constant(false))
}
