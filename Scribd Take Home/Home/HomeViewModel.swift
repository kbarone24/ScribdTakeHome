//
//  ViewModel.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var books = [Book]()
    @Published var filters = [FilterOption]()
    @Published var isLoading = false

    private var cachedBooks = [Book]()
    private var cancellables = Set<AnyCancellable>()
    let bookService: BookServiceProtocol

    var activeFilter: FilterOption? {
        return filters.first(where: { $0.selected })
    }

    init(serviceContainer: ServiceContainer) {
        guard let bookService = try? serviceContainer.service(for: \.bookService) else {
            bookService = BookService()
            return
        }
        self.bookService = bookService
    }

    func requestBooks() {
        isLoading = true
        Task {
            let results = await bookService.fetchSampleBooks()
            DispatchQueue.main.async {
                self.books = results.books
                self.cachedBooks = results.books
                self.filters = results.filterOptions
                self.isLoading = false
            }
        }
    }

    func toggleBookmark(forBookID id: String) {
        if let i = books.firstIndex(where: { $0.id == id }) {
            books[i].bookmarked.toggle()
        }

        if let i = cachedBooks.firstIndex(where: { $0.id == id }) {
            cachedBooks[i].bookmarked.toggle()
        }
    }

    func applyFilters(_ filters: [FilterOption]) {
        books = cachedBooks
        self.filters = filters
        guard let activeFilter else {
            // return all books
            return
        }
        books = books.filter({ $0.format == activeFilter.bookFormat })
    }
}
