//
//  TabBarPage.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

enum TabBarPage {
    case product
    case settings
    case cart

    init?(index: Int) {
        switch index {
        case 0:
            self = .product
        case 1:
            self = .cart
        case 2:
            self = .settings
        default:
            return nil
        }
    }

    func pageTintColorNumber() -> UIColor {
        switch self {
        case .product:
            return .systemMint
        case .cart:
            return .purple
        case .settings:
            return .systemMint
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .product:
            return 0
        case .cart:
            return 1
        case .settings:
            return 2
        }
    }

    func pageImageNumber() -> UIImage {
        switch self {
        case .product:
            return UIImage(systemName: "house") ?? UIImage()
        case .cart:
            return UIImage(systemName: "cart") ?? UIImage()
        case .settings:
            return UIImage(systemName: "gearshape") ?? UIImage()
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .product:
            return "Product"
        case .cart:
            return "Cart"
        case .settings:
            return "Settings"
        }
    }
}
