//
//  AppFeature.swift
//  MiniMarket
//
//  Created by Sasha Jaroshevskii on 10/19/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
  @Reducer
  enum Path {
    case detail(ProductDetail)
  }
  
  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
    var productsList = ProductsList.State()
  }
  
  enum Action {
    case path(StackActionOf<Path>)
    case productsList(ProductsList.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.productsList, action: \.productsList) {
      ProductsList()
    }
    Reduce { state, action in
      switch action {
      case .path:
        return .none
        
      case .productsList:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

extension AppFeature.Path.State: Equatable {}

struct AppView: View {
  @Bindable var store: StoreOf<AppFeature>
  
  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      ProductsListView(
        store: store.scope(state: \.productsList, action: \.productsList)
      )
    } destination: { store in
      switch store.case {
      case let .detail(detailStore):
        ProductDetailView(store: detailStore)
      }
    }
  }
}

#Preview {
  AppView(
    store: Store(initialState: AppFeature.State()) {
      AppFeature()
        ._printChanges()
    }
  )
}
