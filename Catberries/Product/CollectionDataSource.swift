//
//  CollectionDataSource.swift
//  Catberries
//
//  Created by Илья Черницкий on 3.08.23.
//
//
import UIKit

class CollectionDataSource: NSObject {

    var filteredProductsByCategory: [String: [Product]] = [:]
    var productsByCategory: [String: [Product]] = [:]
    var isSearching: Bool = false

    func searchProductsByValue(_ searchText: String) -> [String: [Product]] {
        if isSearching {
            return productsByCategory.reduce(into: [String: [Product]]()) { (result, entry) in
                let categoryName = entry.key
                let products = entry.value

                let filteredProducts = products.filter { $0.title.lowercased().contains(searchText.lowercased()) }
                if !filteredProducts.isEmpty {
                    result[categoryName] = filteredProducts
                }
            }
        } else {
            return productsByCategory
        }
    }
}
