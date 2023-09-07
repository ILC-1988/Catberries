//
//  BasketCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class CartCoordinator {

    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("CartCoordinator deinit")
    }

    func start(viewModel: CartViewModel) {
        let cartViewModel = viewModel
        let cartViewController = CartViewController(viewModel: cartViewModel)
        navigationController.pushViewController(cartViewController, animated: true)
    }
}
