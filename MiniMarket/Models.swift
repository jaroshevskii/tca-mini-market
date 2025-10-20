//
//  Models.swift
//  MyBestEverProject
//
//  Created by Sasha Jaroshevskii on 10/13/25.
//

import ComposableArchitecture
import Foundation

struct StoreProduct: Identifiable, Decodable, Equatable {
  let id: String
  let title: String
  let price: Decimal
}

extension StoreProduct {
  static let mock = Self(
    id: "1",
    title: "AirPods",
    price: 10.0
  )

  static let mocks: IdentifiedArrayOf<StoreProduct> = [
    .init(id: "1", title: "AirPods Pro", price: 249.99),
    .init(id: "2", title: "iPhone 16 Pro", price: 1199.00),
    .init(id: "3", title: "Apple Watch Ultra 2", price: 799.00),
    .init(id: "4", title: "MacBook Air M3", price: 1299.00),
    .init(id: "5", title: "iPad Pro 13\"", price: 1099.00),
    .init(id: "6", title: "Magic Keyboard", price: 299.00),
    .init(id: "7", title: "Apple Pencil Pro", price: 129.00),
    .init(id: "8", title: "AirTag 4 Pack", price: 99.00),
    .init(id: "9", title: "HomePod mini", price: 99.00),
    .init(id: "10", title: "Apple TV 4K", price: 149.00),
    .init(id: "11", title: "Mac Studio", price: 1999.00),
    .init(id: "12", title: "Studio Display", price: 1599.00),
    .init(id: "13", title: "Pro Display XDR", price: 4999.00),
    .init(id: "14", title: "Mac Pro", price: 6999.00),
    .init(id: "15", title: "Mac mini M2", price: 599.00),
    .init(id: "16", title: "iMac 24\"", price: 1299.00),
    .init(id: "17", title: "AirPods Max", price: 549.00),
    .init(id: "18", title: "Smart Keyboard Folio", price: 179.00),
    .init(id: "19", title: "MagSafe Charger", price: 39.00),
    .init(id: "20", title: "AppleCare+ for iPhone", price: 199.00),
    .init(id: "21", title: "Apple Watch Band – Sport Loop", price: 49.00),
    .init(id: "22", title: "Thunderbolt 4 Pro Cable (1.8 m)", price: 159.00),
    .init(id: "23", title: "USB‑C to Lightning Cable (1 m)", price: 19.00),
    .init(id: "24", title: "Magic Mouse", price: 79.00),
    .init(id: "25", title: "Magic Trackpad", price: 129.00)
  ]
}
