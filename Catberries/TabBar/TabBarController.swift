//
//  ViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

final class TabBarController: UITabBarController {

    private let cartTabIndex = 1
    var cartItemsCount: Int = 0 {
        didSet {
            updateCartBadgeValue()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartItemsCount = UserSessionManager.shared.getData(key: "Cart").count
    }

    private func setupTabBar() {
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
    }

    private func updateCartBadgeValue() {
            if let cartTab = tabBar.items?[cartTabIndex] {
                cartTab.badgeValue = cartItemsCount > 0 ? "\(cartItemsCount)" : nil
            }
        }

    func updateCartItemsCount(count: Int) {
        cartItemsCount = count
    }
}
