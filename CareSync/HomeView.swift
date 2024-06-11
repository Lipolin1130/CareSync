//
//  HomeView.swift
//  CareSync
//
//  Created by Mac on 2024/6/9.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView (selection: $selectedTab) {
            InformationView()
                .tabItem {
                    Label("Calendar", systemImage:"calendar.badge.checkmark")
                }
            
            Text("Second Page")
                .tabItem {
                    Label("Calendar", systemImage:"plus")
                }
            
            Text("Third Page")
                .tabItem {
                    Label("plus", systemImage:"plus")
                }
            
            Text("Fourth Page")
                .tabItem {
                    Label("plus", systemImage:"plus")
                }
            
            Text("Fifth Page")
                .tabItem {
                    Label("Calendar", systemImage:"plus")
                }
        }
    }
}

#Preview {
    HomeView()
}
