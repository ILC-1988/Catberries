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

    var type: CoordinatorType { .product }

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
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem.init(title: nil,
                           image: page.pageImageNumber(),
                           tag: page.pageOrderNumber())

        switch page {
        case .product:
            let firstViewController = ProductViewController()
            navController.pushViewController(firstViewController, animated: true)
        case .cart:
            let secondViewController = CartViewController()
            navController.pushViewController(secondViewController, animated: true)
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

    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}
