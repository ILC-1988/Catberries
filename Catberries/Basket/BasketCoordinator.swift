//
//  BasketCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class BasketCoordinator: Coordinator {
    
    let viewModel: BasketViewModel
    
    init(navigationController: UINavigationController, viewModel: BasketViewModel) {
        self.viewModel = viewModel
        
        super.init(navigationController: navigationController)
    }

}
