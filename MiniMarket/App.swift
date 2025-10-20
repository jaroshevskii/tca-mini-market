//
//  App.swift
//  MiniMarket
//
//  Created by Sasha Jaroshevskii on 10/18/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct MiniMarketApp: App {
  static let store = Store(initialState: AppFeature.State()) {
    AppFeature()
  }
  
  var body: some Scene {
    WindowGroup {
      if isTesting {
        EmptyView()
      } else {
        AppView(store: Self.store)
      }
    }
  }
}
