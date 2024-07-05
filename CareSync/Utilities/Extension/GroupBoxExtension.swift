//
//  GroupBoxExtension.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import SwiftUI
import Foundation

struct MedicalRecordGroupBoxStyle: GroupBoxStyle {
    
    var centerOrLeading: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: centerOrLeading ? .center : .leading, spacing: 10) {
            if centerOrLeading {
                HStack {
                    configuration.label
                        .bold()
                    Spacer()
                }
            } else {
                configuration.label
                    .bold()
            }
            
            configuration.content
                .padding(.leading, centerOrLeading ? 0 : 30)
        }
        .padding([.leading, .top], 20)
        .frame(minHeight: 120, alignment: .top)
        .frame(width: 320, alignment: centerOrLeading ? .center : .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        
    }
}

struct PersonHealthGroupBoxStyle: GroupBoxStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            
            configuration.label
                .bold()
            
            configuration.content
                .padding(.top, 5)
                .font(.subheadline)
        }
        .background(.white)
//        .padding(.horizontal, 10)
    }
}

extension GroupBoxStyle where Self == PersonHealthGroupBoxStyle {
    static func personHealth() -> PersonHealthGroupBoxStyle {
        PersonHealthGroupBoxStyle()
    }
}

extension GroupBoxStyle where Self == MedicalRecordGroupBoxStyle {
    static func medicalRecord(centerOrLeading: Bool ) -> MedicalRecordGroupBoxStyle {
        MedicalRecordGroupBoxStyle(centerOrLeading: centerOrLeading)
    }
}
