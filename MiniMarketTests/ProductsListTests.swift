//
//  ProductsListTests.swift
//  MiniMarketTests
//
//  Created by Sasha Jaroshevskii on 10/19/25.
//

import ComposableArchitecture
import Foundation
import Testing

@testable import MiniMarket

@MainActor
struct ProductsListTests {
  @Test func fetchProductsSucceeds() async {
    let mockProducts = Product.mocks
    
    let store = TestStore(initialState: ProductsList.State()) {
      ProductsList()
    } withDependencies: {
      $0.productsClient.fetch = { mockProducts }
    }

    await store.send(.onTask) {
      $0.isProductsFetching = true
    }
    
    await store.receive(\.fetchResponse.success) {
      $0.isProductsFetching = false
      $0.products = mockProducts
    }
  }
  
  @Test func fetchProductsFails() async {
    struct TestError: Error, Equatable {}
    
    let store = TestStore(initialState: ProductsList.State()) {
      ProductsList()
    } withDependencies: {
      $0.productsClient.fetch = { throw TestError() }
    }

    await store.send(.onTask) {
      $0.isProductsFetching = true
    }

    await store.receive(\.fetchResponse.failure) {
      $0.isProductsFetching = false
    }
  }
}
