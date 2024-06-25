//
//  GroupBoxExtension.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import SwiftUI
import Foundation

struct MedicalRecordGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            configuration.label
                .bold()
                .fontDesign(.monospaced)
            
            configuration.content
                .padding(.leading, 30)
        }
        .padding([.leading, .top], 20)
        .frame(minHeight: 120, alignment: .top)
        .frame(width: 320, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

extension GroupBoxStyle where Self == MedicalRecordGroupBoxStyle {
    static var medicalRecord: MedicalRecordGroupBoxStyle { .init() }
}
