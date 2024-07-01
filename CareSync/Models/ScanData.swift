//
//  ScanData.swift
//  CareSync
//
//  Created by Mac on 2024/7/2.
//

import Foundation

struct ScanData: Identifiable {
    let id = UUID()
    let contnet: String
    
    init(contnet: String) {
        self.contnet = contnet
    }
}
