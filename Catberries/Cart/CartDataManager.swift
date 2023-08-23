//
//  CartDataManager.swift
//  Catberries
//
//  Created by Илья Черницкий on 23.08.23.
//

import Foundation

class CartDataManager {
    static let shared = CartDataManager()

    func getCartItems() -> [UserData] {
        UserSessionManager.shared.getData(key: "Cart")
    }
}
