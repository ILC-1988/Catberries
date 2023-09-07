//
//  BasketViewModel.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

protocol CartDelegate: AnyObject {
    func didUpdateCart()
}

protocol CartTabDelegate: AnyObject {
    func updateCartItemsCount()
}

class CartViewModel: NSObject {
    var cartItems: [UserData] = []
    weak var cartDelegate: CartDelegate?
    weak var cartTabDelegate: CartTabDelegate?

    func addItemToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product == product }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = UserData(product: product, quantity: 1)
            cartItems.append(newItem)
        }
        UserSessionManager.shared.setData(key: "Cart", to: cartItems)
        cartDelegate?.didUpdateCart()
    }

    func removeItemFromCart(at index: Int) {
        cartItems.remove(at: index)
        cartTabDelegate?.updateCartItemsCount()
    }

    func clearCart() {
        cartItems.removeAll()
        cartTabDelegate?.updateCartItemsCount()
        UserSessionManager.shared.setData(key: "Cart", to: cartItems)
    }

    func updateQuantity(at index: Int, newQuantity: Int) {
        cartItems[index].quantity = newQuantity
    }

    func fetchCartItems() {
        cartItems = CartDataManager.shared.getCartItems()
    }

    func calculateTotal() -> Int {
        let total = cartItems.reduce(0) { $0 + $1.product.price * $1.quantity }
        return total
    }
}
