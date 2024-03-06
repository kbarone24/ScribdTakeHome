//
//  Book.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import Foundation
import UIKit

struct Book {
    var id: String
    var title: String
    var author: String
    var rating: Double
    var format: BookFormat

    var bookmarked: Bool
    var imageData: UIImage? // replace with imageURL when downloading image data from server

    init(title: String, author: String, rating: Double, format: BookFormat, imageData: UIImage? = nil) {
        self.id = UUID().uuidString
        self.title = title
        self.author = author
        self.rating = rating
        self.format = format

        self.bookmarked = false
        self.imageData = imageData
    }
}

extension Book: Hashable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.author == rhs.author &&
        lhs.rating == rhs.rating &&
        lhs.format == rhs.format &&
        lhs.bookmarked == rhs.bookmarked
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(author)
        hasher.combine(rating)
        hasher.combine(format)
        hasher.combine(bookmarked)
    }

}
