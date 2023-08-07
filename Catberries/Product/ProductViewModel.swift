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
    
    func updateData(with newData: [String: [Product]], filteredProductsByCategory filterData: [String: [Product]], isSearching newIsSearching: Bool) {
        DispatchQueue.main.async {
            self.filteredProductsByCategory = filterData
            self.productsByCategory = newData
            self.isSearching = newIsSearching
            self.collectionView?.reloadData()
            
            self.collectionDataSource.productsByCategory = self.productsByCategory
            self.collectionDataSource.filteredProductsByCategory = self.filteredProductsByCategory
            self.collectionDataSource.isSearching = self.isSearching
            
            self.dataClosure?(self.productsByCategory, self.filteredProductsByCategory, self.isSearching)
        }
    }
    
    func attach() {
        apiClient.fetchProductsFromAPI { [weak self] productsByCategory in
            DispatchQueue.main.async {
                self?.productsByCategory = productsByCategory
                self?.collectionDataSource.productsByCategory = productsByCategory
                self?.dataClosure?(productsByCategory, [:], false)
            }
        }
    }
}
