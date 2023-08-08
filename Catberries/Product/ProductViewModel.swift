//
//  ProductViewModel.swift
//  Catberries
//
//  Created by Илья Черницкий on 30.07.23.
//

import Foundation
import UIKit

class ProductViewModel: NSObject {

    let collectionDataSource = CollectionDataSource()
    var collectionView: UICollectionView?
    private let apiClient = APIClient()
    var filteredProductsByCategory: [String: [Product]] = [:]
    var productsByCategory: [String: [Product]] = [:]
    var isSearching: Bool = false
    var dataClosure: (([String: [Product]], [String: [Product]], Bool) -> Void)?

    func attach() {
        apiClient.fetchProductsFromAPI { [weak self] productsByCategory in
            DispatchQueue.main.async {
                 self?.dataClosure?(productsByCategory, [:], false)
            }
        }
    }
}
