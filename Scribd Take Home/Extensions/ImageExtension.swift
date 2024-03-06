//
//  ImageExtension.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import SwiftUI

extension Image {
    enum SFSymbol: String {
        case DefaultBook = "text.book"
        case Bookmark = "bookmark"
        case BookmarkFill = "bookmark.fill"
        case DownCarat = "chevron.down"
        case Star = "star"
        case StarFill = "star.fill"
        case StarHalfFill = "star.leadinghalf.filled"
        case XCircle = "x.circle.fill"
        case Box = "square"
        case CheckedBox = "x.square"
    }

    init(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}
