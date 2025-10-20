//
//  ProductsList.swift
//  MyBestEverProject
//
//  Created by Sasha Jaroshevskii on 10/13/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ProductsList {
  @ObservableState
  struct State: Equatable {
    var products: IdentifiedArrayOf<StoreProduct> = []
    var searchedProducts: IdentifiedArrayOf<StoreProduct> = []
    var isProductsFetching = false
    var searchQuery = ""
        
    var displayProducts: IdentifiedArrayOf<StoreProduct> {
      searchQuery.isEmpty ? products : searchedProducts
    }
  }
    
  enum Action {
    case fetchResponse(Result<IdentifiedArrayOf<StoreProduct>, any Error>)
    case onTask
    case searchQueryChangeDebounced
    case searchQueryChanged(String)
    case searchResponse(Result<IdentifiedArrayOf<StoreProduct>, any Error>)
  }
    
  @Dependency(\.productsClient) var productsClient
  
  private enum CancelID { case search }
    
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onTask:
        guard state.products.isEmpty else {
          return .none
        }
        state.isProductsFetching = true
        return .run { send in
          await send(.fetchResponse(Result { try await productsClient.fetch() }))
        }
        
      case let .fetchResponse(result):
        state.isProductsFetching = false
        if case let .success(products) = result {
          state.products = products
        }
        return .none
        
      case let .searchQueryChanged(query):
        state.searchQuery = query
        if state.searchQuery.isEmpty {
          state.searchedProducts = []
          return .cancel(id: CancelID.search)
        }
        return .none
        
      case .searchQueryChangeDebounced:
        guard !state.searchQuery.isEmpty else {
          return .none
        }
        return .run { [query = state.searchQuery] send in
          await send(.searchResponse(Result { try await productsClient.search(query) }))
        }
        .cancellable(id: CancelID.search, cancelInFlight: true)
        
      case let .searchResponse(result):
        if case let .success(products) = result {
          state.searchedProducts = products
        }
        return .none
      }
    }
  }
}

struct ProductsListView: View {
  @Bindable var store: StoreOf<ProductsList>
  
  var body: some View {
    List {
      if store.isProductsFetching {
        ForEach(0..<16) { _ in
          CardView(product: nil)
        }
      } else {
        ForEach(store.displayProducts) { product in
          NavigationLink(
            state: AppFeature.Path.State.detail(ProductDetail.State(product: product))
          ) {
            CardView(product: product)
          }
        }
      }
    }
    .navigationTitle("Products")
    .searchable(text: $store.searchQuery.sending(\.searchQueryChanged))
    .task { await store.send(.onTask).finish() }
    .task(id: store.searchQuery) {
      do {
        try await Task.sleep(for: .milliseconds(300))
        await store.send(.searchQueryChangeDebounced).finish()
      } catch {}
    }
  }
}

#Preview {
  NavigationStack {
    ProductsListView(
      store: StoreOf<ProductsList>(
        initialState: ProductsList.State()
      ) {
        ProductsList()
      }
    )
  }
}

struct CardView: View {
  let product: StoreProduct?

  @ViewBuilder
  var body: some View {
    if let product {
      HStack {
        Text(product.title)
        Spacer()
        Text(product.price.formatted(.number))
      }
    } else {
      HStack {
        RoundedRectangle(cornerRadius: 6)
          .fill(.gray.opacity(0.3))
          .frame(width: 120, height: 16)
        Spacer()
      }
    }
  }
}
