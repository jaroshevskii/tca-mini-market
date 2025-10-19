//
//  MiniMarketApp.swift
//  MiniMarket
//
//  Created by Sasha Jaroshevskii on 10/18/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct MiniMarketApp: App {
  static let store = Store(initialState: ProductsList.State()) {
    ProductsList()
      ._printChanges()
  }
  
  var body: some Scene {
    WindowGroup {
      if isTesting {
        EmptyView()
      } else {
        NavigationStack {
          ProductsListView(store: Self.store)
        }
      }
    }
  }
}
