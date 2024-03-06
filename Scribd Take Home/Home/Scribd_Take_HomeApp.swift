//
//  Scribd_Take_HomeApp.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import SwiftUI

@main
struct Scribd_Take_HomeApp: App {
    init() {
        registerServices()
    }
    var body: some Scene {
        WindowGroup {
            HomeContentView(viewModel: HomeViewModel(serviceContainer: .shared))
        }
    }

    private func registerServices() {
        do {
            let bookService = BookService()
            try ServiceContainer.shared.register(service: bookService, for: \.bookService)
        } catch {
            fatalError("Unable to initialize services: \(error.localizedDescription)")
        }
    }
}
