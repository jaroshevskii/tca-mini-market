//
//  ProductDetail.swift
//  MiniMarket
//
//  Created by Sasha Jaroshevskii on 10/19/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ProductDetail {
  @ObservableState
  struct State: Equatable {
    let product: StoreProduct
  }
  
  enum Action {
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      }
    }
  }
}

struct ProductDetailView: View {
  @Bindable var store: StoreOf<ProductDetail>
  
  var body: some View {
    Text(store.product.title)
  }
}
