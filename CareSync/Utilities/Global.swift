//
//  Global.swift
//  SwiftUICalendar
//
//  Created by GGJJack on 2021/10/22.
//

import Foundation
import SwiftUI

class Global {
    static let MAX_PAGE = 100
    static let CENTER_PAGE = 100 / 2
}

public enum Orientation {
    case horizontal
    case vertical
}

public enum HeaderSize {
    case zero
    case ratio
    case fixHeight(CGFloat)
}
