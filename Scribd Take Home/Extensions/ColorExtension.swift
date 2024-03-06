//
//  UIColorExtension.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import SwiftUI

extension Color {
    init(color: CustomColor) {
        self.init(color.rawValue)
    }
}

