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
    var gender: Bool // 性別 1: 男生, 0: 女生
    var imageName: String
    var height: Double // cm
    var weight: Double // kg
    var bloodType: String
    var birthDate: Date
    var medicalHistory: [String] // 疾病史
    var medicalFamily: [String] // 家族史
    var allergy: [String] // 一般過敏
    var drugAllergy: [String] // 藥物過敏
    
    init(name: String, color: Color = Color.primary, gender: Bool, imageName: String, height: Double, weight: Double, bloodType: String, birthDate: Date, medicalHistory: [String], medicalFamily: [String], allergy: [String], drugAllergy: [String]) {
        self.name = name
        self.color = color
        self.gender = gender
        self.imageName = imageName
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.birthDate = birthDate
        self.medicalHistory = medicalHistory
        self.medicalFamily = medicalFamily
        self.allergy = allergy
        self.drugAllergy = drugAllergy
    }
    
    var age: Double {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year, .month, .day], from: birthDate, to: now)
        
        let years = Double(ageComponents.year ?? 0)
        let months = Double(ageComponents.month ?? 0) / 12.0
        let days = Double(ageComponents.day ?? 0) / 365.25
        return years + months + days
    }
    
    var bmi: Double {
        return weight / ((height / 100 ) * (height / 100))
    }
    
    var bmiDescription: String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<24.9:
            return "Normal weight"
        case 25..<29.9:
            return "Overweight"
        case 30..<34.9:
            return "Obesity I"
        case 35..<39.9:
            return "Obesity II"
        default:
            return "Obesity III"
        }
    }
    
    var bmiColor: Color {
        switch bmi {
        case ..<18.5:
            return Color.green
        case 18.5..<24.9:
            return Color.blue
        case 25..<29.9:
            return Color.yellow
        case 30..<34.9:
            return Color.orange
        case 35..<39.9:
            return Color.red
        default:
            return Color.purple
        }
    }
}
