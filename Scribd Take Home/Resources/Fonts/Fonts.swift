//
//  Fonts.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import Foundation
import UIKit
import SwiftUI

enum FontType: String {
    case regular = "SFProDisplay-Regular"
    case semibold = "SFProDisplay-Semibold"
    case medium = "SFProDisplay-Medium"

    var name: String {
        return self.rawValue
    }
}

struct CustomFont {
    let font: FontType
    let size: CGFloat
    let style: UIFont.TextStyle
}

enum TextStyle {
    case header
    case subheader
    case bookTitle
    case bookAuthor
    case paragraph
    case smallButton
    case largeButton
}

extension TextStyle {
    private var customFont: CustomFont {
        switch self {
        case .header:
            return CustomFont(font: .semibold, size: 20, style: .headline)
        case .subheader:
            return CustomFont(font: .semibold, size: 18, style: .body)
        case .bookTitle:
            return CustomFont(font: .semibold, size: 24, style: .headline)
        case .bookAuthor:
            return CustomFont(font: .regular, size: 20, style: .body)
        case .paragraph:
            return CustomFont(font: .medium, size: 14, style: .body)
        case .smallButton:
            return CustomFont(font: .semibold, size: 18, style: .callout)
        case .largeButton:
            return CustomFont(font: .medium, size: 24, style: .callout)
        }
    }
}

extension TextStyle {
    var uiFont: UIFont {
        guard let font = UIFont(name: customFont.font.name, size: customFont.size) else {
            return UIFont.preferredFont(forTextStyle: customFont.style)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: customFont.style)
        return fontMetrics.scaledFont(for: font)
    }

    var font: Font {
        return Font(UIFont(name: customFont.font.name, size: customFont.size) ?? .systemFont(ofSize: customFont.size))
    }
}

