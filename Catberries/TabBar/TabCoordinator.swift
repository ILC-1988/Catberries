//
//  TabCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

class TabCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    let cartViewModel = CartViewModel()
    var type: CoordinatorType { .tab }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = TabBarController()
    }

    func start() {

        let pages: [TabBarPage] = [.cart, .settings, .product]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })

        let controllers: [UINavigationController] = pages.map({ getTabController($0) })

        prepareTabBarController(withTabControllers: controllers)
    }

    deinit {
        print("TabCoordinator deinit")
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.product.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: true)
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                           image: page.pageImageNumber(),
                           tag: page.pageOrderNumber())

        switch page {
        case .product:
            let firstViewController = ProductViewController()
            firstViewController.viewModel.delegate = self
            firstViewController.addToCartClosure = { [weak self] product in
                self?.addElementToCart(product: product)
            }
            navController.pushViewController(firstViewController, animated: true)
        case .cart:
            let cartCoordinator = CartCoordinator(navigationController: navController)
            cartViewModel.cartTabDelegate = self
            cartViewModel.cartItems = UserSessionManager.shared.getData(key: "Cart")
            cartCoordinator.start(viewModel: cartViewModel)
        case .settings:
            let thirdViewController = SettingsViewController()
            thirdViewController.didSendEventClosure = { [weak self] event in
                switch event {
                case .settings:
                    self?.finish()
                }
            }
            navController.pushViewController(thirdViewController, animated: true)
        }
        return navController
    }

    func currentPage() -> TabBarPage? {
        TabBarPage.init(index: tabBarController.selectedIndex)
    }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

extension TabCoordinator: ProductViewControllerDelegate {
    func didSelectCell(at product: Product) {
        showProductDescriptionViewController(product: product)
    }

    func showProductDescriptionViewController(product: Product) {
        guard let navigationController = tabBarController.viewControllers?[0] as? UINavigationController else { return }
        let productDescriptionVC = ProductDescriptionViewController()
        productDescriptionVC.product = product
        productDescriptionVC.addToCartClosure = { [weak self] event in
            switch event {
            case .addCart:
                self?.addElementToCart(product: product)
            }
        }
        navigationController.pushViewController(productDescriptionVC, animated: true)
    }

    func addElementToCart(product: Product) {
        cartViewModel.addItemToCart(product: product)
        updateCartItemsCount()
    }

    func updateCartItemCount() {
        if let mainTabBarController = tabBarController as? TabBarController {
            mainTabBarController.updateCartItemsCount(count: cartViewModel.cartItems.count)
        }
    }

}

extension TabCoordinator: CartTabDelegate {
    func updateCartItemsCount() {
        updateCartItemCount()
    }
}
