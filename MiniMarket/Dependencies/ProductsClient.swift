//
//  ProductsClient.swift
//  MyBestEverProject
//
//  Created by Sasha Jaroshevskii on 10/13/25.
//

import ComposableArchitecture
import Foundation

struct ProductsClient {
    var fetch: @Sendable () async throws -> IdentifiedArrayOf<StoreProduct>
    var search: @Sendable (_ query: String) async throws -> IdentifiedArrayOf<StoreProduct>
}

extension ProductsClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
            try await Task.sleep(for: .milliseconds(100))
            return StoreProduct.mocks
        },
        search: { query in
            try await Task.sleep(for: .milliseconds(100))
            return StoreProduct.mocks.filter { $0.title.localizedCaseInsensitiveContains(query) }
        }
    )
    
//    static let liveValue = Self(
//        fetch: {
//            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://some-api.com/products")!)
//            return try JSONDecoder().decode(IdentifiedArrayOf<Product>.self, from: data)
//        }
//    )
    
//    static let previewValue = Self(
//        fetch: {
//            try await Task.sleep(for: .seconds(1))
//            return [.mock]
//        }
//    )
}

extension DependencyValues {
    var productsClient: ProductsClient {
        get { self[ProductsClient.self] }
        set { self[ProductsClient.self] = newValue }
    }
}
