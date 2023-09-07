//
//  CartViewModel+Extension.swift
//  Catberries
//
//  Created by Илья Черницкий on 7.09.23.
//

import UIKit

// MARK: UITableViewDataSource
extension CartViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
        if let cell = cell as? CartItemCell {
            let cartItem = cartItems[indexPath.row]
            cell.configure(with: cartItem)
            cell.delegate = self
        }
        return cell
    }
}

// MARK: UITableViewDelegate
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

// MARK: CartItemCellDelegate
extension CartViewModel: CartItemCellDelegate {
    func didTapButton(in cell: CartItemCell, add: Bool) {
        guard let tableView = cell.superview as? UITableView else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        if add {
            cartItems[indexPath.row].quantity += 1
        } else {
            cartItems[indexPath.row].quantity -= 1
            if cartItems[indexPath.row].quantity == 0 {
                removeItemFromCart(at: indexPath.row)
            }
        }
        UserSessionManager.shared.setData(key: "Cart", to: cartItems)
        cartDelegate?.didUpdateCart()
        tableView.reloadData()
    }
}
