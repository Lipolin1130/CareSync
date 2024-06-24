//
//  Person.swift
//  CareSync
//
//  Created by Mac on 2024/6/14.
//

import SwiftUI

class Person: ObservableObject, Identifiable {
    let id = UUID().uuidString
    var name: String
    @Published var color: Color
    
    init(name: String, color: Color) {
        self.name = name
        self.color = color
    }
    
    init(name: String) {
        self.name = name
        self.color = Color.primary
    }
}
