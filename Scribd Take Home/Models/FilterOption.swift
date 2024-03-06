//
//  FilterOption.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import Foundation

struct FilterOption {
    var id: String
    var bookFormat: BookFormat
    var selected: Bool = false

    init(bookFormat: BookFormat) {
        self.id = UUID().uuidString
        self.bookFormat = bookFormat
    }
}

extension FilterOption: Hashable {
    static func == (lhs: FilterOption, rhs: FilterOption) -> Bool {
        return lhs.id == rhs.id &&
        lhs.bookFormat == rhs.bookFormat &&
        lhs.selected == rhs.selected
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(bookFormat)
        hasher.combine(selected)
    }
}
