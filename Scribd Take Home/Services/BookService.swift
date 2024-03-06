//
//  BookService.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import Foundation
import UIKit

protocol BookServiceProtocol {
    func fetchSampleBooks() async -> (books: [Book], filterOptions: [FilterOption])
}

final class BookService: BookServiceProtocol {
    let mockDataSource: [Book] = [
        Book(title: "American Gods", author: "Neil Gaiman", rating: 4.25, format: .Audiobook, imageData: UIImage(asset: .AmericanGods)),
        Book(title: "The Savage Detectives", author: "Roberto Bolaño", rating: 4.2, format: .Audiobook, imageData: UIImage(asset: .TheSavageDetectives)),
        Book(title: "Giovanni's Room", author: "James Baldwin", rating: 4.5, format: .Audiobook, imageData: UIImage(asset: .GiovannisRoom)),
        Book(title: "I Who Have Never Known Men", author: "Jacqueline Harpman", rating: 3.75, format: .Audiobook, imageData: UIImage(asset: .IWhoHaveNeverKnownMen)),
        Book(title: "New Dark Age", author: "James Bridle", rating: 4.0, format: .Audiobook, imageData: UIImage(asset: .NewDarkAge)),
        Book(title: "Underworld", author: "Don Delillo", rating: 4.4, format: .EBook, imageData: UIImage(asset: .Underworld)),
        Book(title: "Her Body and Other Parties", author: "Carmen Maria Machado", rating: 4.0, format: .EBook, imageData: UIImage(asset: .HerBodyAndOtherParties)),
        Book(title: "The Pilgrim at Tinker Creek", author: "Annie Dillard", rating: 3.5, format: .EBook, imageData: UIImage(asset: .PilgrimAtTinkerCreek)),
        Book(title: "Lot", author: "Bryan Washington", rating: 4.5, format: .EBook, imageData: UIImage(asset: .Lot)),
        Book(title: "Island", author: "Aldous Huxley", rating: 4.2, format: .EBook, imageData: UIImage(asset: .Island)),
    ]
    
    func fetchSampleBooks() async -> (books: [Book], filterOptions: [FilterOption]) {
        do {
            // mimic async database call
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let books = mockDataSource.shuffled()

            let formats = books.map { $0.format }.removingDuplicates()
            var filterOptions: [FilterOption] = []
            for format in formats {
                filterOptions.append(FilterOption(bookFormat: format))
            }
            
            return (books, filterOptions)
        } catch {
            return ([], [])
        }
    }
}
