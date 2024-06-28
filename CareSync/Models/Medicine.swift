//
//  Medicine.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import Foundation

class Medicine: Identifiable {
    let id = UUID().uuidString
    var name: String
    var appearance: String //外觀
    var instructions: String // 使用方法
    var sideEffect: String //副作用
    var precautions: String // 注意事項
    
    init(name: String, appearance: String, instructions: String, sideEffect: String, precautions: String) {
        self.name = name
        self.appearance = appearance
        self.instructions = instructions
        self.sideEffect = sideEffect
        self.precautions = precautions
    }
}
