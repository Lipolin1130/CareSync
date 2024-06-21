//
//  CustomTabBar.swift
//  CareSync
//
//  Created by Mac on 2024/6/12.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @Binding var addCalendarInfoSheet: Bool
    
    private let tabItems: [(imageName: String, tabIndex: Int)] = [
        ("calendar.badge.checkmark", 0),
        ("person.and.person", 1),
        ("plus", 2),
        ("plus", 3),
        ("plus", 4)
    ]
    
    var body: some View {
        HStack {
            ForEach(tabItems, id: \.tabIndex) { item in
                Button {
                    if item.tabIndex == 2 {
                        addCalendarInfoSheet = true
                    } 
                    selectedTab = item.tabIndex
                } label: {
                    VStack {
                        Image(systemName: item.imageName)
                    }
                    .foregroundColor(selectedTab == item.tabIndex ? .blue : .gray)
                    .frame(width: 30, height: 30)
                    .padding()
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
                 addCalendarInfoSheet: .constant(false))
}
