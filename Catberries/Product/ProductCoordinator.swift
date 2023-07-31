//
//  ProductCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class ProductCoordinator: Coordinator {
    
    let viewModel: ProductViewModel
    
    init(navigationController: UINavigationController, viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        super.init(navigationController: navigationController)
    }

}

