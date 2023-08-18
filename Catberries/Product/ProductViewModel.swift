//
//  ProductViewModel.swift
//  Catberries
//
//  Created by Илья Черницкий on 30.07.23.
//

import Foundation
import UIKit

protocol ProductViewControllerDelegate: class {
    func didSelectCell(at product: Product)
}

final class ProductViewModel: NSObject {

    let collectionDataSource = CollectionDataSource()
    private let apiClient = APIClient()
    var dataClosure: (([String: [Product]], [String: [Product]], Bool) -> Void)?
    weak var delegate: ProductViewControllerDelegate?

    func attach() {
        apiClient.fetchProductsFromAPI { [weak self] productsByCategory in
            DispatchQueue.main.async {
                 self?.dataClosure?(productsByCategory, [:], false)
            }
        }
    }
}
