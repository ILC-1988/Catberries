//
//  Protocols.swift
//  Catberries
//
//  Created by Илья Черницкий on 7.09.23.
//

import UIKit

// MARK: - LoginCoordinatorProtocol
protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

// MARK: - CollectionDataSourceDelegate
protocol CollectionDataSourceDelegate: class {
    func addToCartButtonTapped(for product: Product)
}

// MARK: - ProductCellDelegate
protocol ProductCellDelegate: class {
    func addToCart(for product: Product)
}

// MARK: - ProductViewControllerDelegate
protocol ProductViewControllerDelegate: class {
    func didSelectCell(at product: Product)
}

// MARK: - CartItemCellDelegate
protocol CartItemCellDelegate: AnyObject {
    func didTapButton(in cell: CartItemCell, add: Bool)
}

// MARK: - CartDelegate
protocol CartDelegate: AnyObject {
    func didUpdateCart()
}

// MARK: - CartTabDelegate
protocol CartTabDelegate: AnyObject {
    func updateCartItemsCount()
}

// MARK: - Coordinator
protocol Coordinator: class {
    var finishDelegate: CoordinatorFinishDelegate? { get set }

    var navigationController: UINavigationController { get set }

    var childCoordinators: [Coordinator] { get set }

    var type: CoordinatorType { get }

    func start()

    func finish()

    init(_ navigationController: UINavigationController)
}

// MARK: - CoordinatorFinishDelegate
protocol CoordinatorFinishDelegate: class {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
