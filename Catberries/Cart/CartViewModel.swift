//
//  BasketViewModel.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

protocol CartDelegate: class {
    func didUpdateCart()
}

protocol CartTabDelegate: class {
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
        let total = cartItems.reduce(0) { $0 + $1.product.price }
        return total
    }
}

extension CartViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
        if let cell = cell as? CartItemCell {
            let cartItem = cartItems[indexPath.row]
            cell.configure(with: cartItem)
        }
        return cell
    }
}

extension CartViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserSessionManager.shared.setData(key: "Cart", to: cartItems)
            cartDelegate?.didUpdateCart()
            cartTabDelegate?.updateCartItemsCount()
            tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView,
                       viewForHeaderInSection section: Int) -> UIView? {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView")
            if let headerView = headerView as? CartHeaderFooterView {
                headerView.titleLabel.text = "Your cart"
            }
            return headerView
        }

        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 32
        }

}
