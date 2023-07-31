//
//  ProductInfoCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class ProductInfoCoordinator: Coordinator {
    
    let viewModel: ProductInfoViewModel
    
    init(navigationController: UINavigationController, viewModel: ProductInfoViewModel) {
        self.viewModel = viewModel
        
        super.init(navigationController: navigationController)
    }

}
