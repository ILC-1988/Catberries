//
//  CartViewController+Extension.swift
//  Catberries
//
//  Created by Илья Черницкий on 7.09.23.
//

// MARK: CartDelegate
extension CartViewController: CartDelegate {
    func didUpdateCart() {
        updateCart()
    }
}
