//
//  ServiceContainer.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import Foundation

final class ServiceContainer {
    // MARK: Error Types
    enum RegistrationError: Error {
        case alreadyRegistered
        case readOnlyViolation
    }

    enum FetchError: Error {
        case notFound
    }

    static let shared = ServiceContainer()

    // MARK: Service dependencies
    private(set) var bookService: BookServiceProtocol?

    // MARK: Interface
    func register<T>(service: T, for keyPath: KeyPath<ServiceContainer, T?>) throws {

        guard let writeableKeyPath = keyPath as? ReferenceWritableKeyPath else {
            throw RegistrationError.readOnlyViolation
        }

        guard self[keyPath: writeableKeyPath] == nil else {
            throw RegistrationError.alreadyRegistered
        }

        self[keyPath: writeableKeyPath] = service
    }

    func service<T>(for keyPath: KeyPath<ServiceContainer, T?>) throws -> T {
        guard let service = self[keyPath: keyPath] else {
            throw FetchError.notFound
        }
        return service
    }
}
