//
//  MultiSelectPicker.swift
//  CareSync
//
//  Created by Mac on 2024/6/30.
//

import SwiftUI

struct MultiSelectPicker: View {
    var items: [MealTime]
    @Binding var selections: [MealTime]
    
    var body: some View {
        List {
            Section {
                ForEach(items, id: \.self) {item in
                    HStack {
                        Text(item.description)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text(item.time)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.trailing, selections.contains(item) ? 0 : 26)
                        
                        if selections.contains(item) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if selections.contains(item) {
                            selections.removeAll {
                                $0 == item
                            }
                        } else {
                            selections.append(item)
                        }
                    }
                }
            } header: {
                Text("Eat Medicine Time")
            } footer: {
                Text("You must choose one")
            }
        }
    }
}

#Preview {
    MultiSelectPicker(items: MealTime.allCases, selections: .constant([]))
}
