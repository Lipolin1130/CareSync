//
//  Medicine.swift
//  CareSync
//
//  Created by Mac on 2024/6/26.
//

import Foundation

class Medicine: Identifiable {
    let id = UUID().uuidString
    @Published var name: String
    @Published var appearance: String // 外觀
    @Published var instructions: String // 使用方法
    @Published var sideEffect: String // 副作用
    @Published var precautions: String // 注意事項
    
    init(name: String, appearance: String, instructions: String, sideEffect: String, precautions: String) {
        self.name = name
        self.appearance = appearance
        self.instructions = instructions
        self.sideEffect = sideEffect
        self.precautions = precautions
    }
    
    init() {
        self.name = ""
        self.appearance = ""
        self.instructions = ""
        self.sideEffect = ""
        self.precautions = ""
    }
}
