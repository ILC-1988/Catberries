//
//  UITabBarItem+Extention.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

extension UITabBarItem: Bindable {
    func bind(to coordinator: Coordinator, at index: Int) {
        coordinator.tabBarItemTapped(sender: index)
    }
}




