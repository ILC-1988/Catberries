//
//  CollectionDataSource.swift
//  Catberries
//
//  Created by Илья Черницкий on 3.08.23.
//
//
import UIKit

class CollectionDataSource: NSObject, UICollectionViewDataSource {

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

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categories: [String]
        let category: String

        if isSearching {
            categories = Array(filteredProductsByCategory.keys)
            if !categories.isEmpty {
                category = categories[section]
                return filteredProductsByCategory[category]?.count ?? 0
            }
        } else {
            categories = Array(productsByCategory.keys)
            if !categories.isEmpty {
                category = categories[section]
                return productsByCategory[category]?.count ?? 0
            }
        }

        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isSearching {
            return filteredProductsByCategory.count
        } else {
            return productsByCategory.count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                            for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }

        let item: Product?
        let categories: [String]
        let category: String

        if isSearching {
            categories = Array(filteredProductsByCategory.keys)
            if !categories.isEmpty {
                category = categories[indexPath.section]
                item = filteredProductsByCategory[category]?[indexPath.item]
            } else {
                item = nil
            }
        } else {
            categories = Array(productsByCategory.keys)
            if !categories.isEmpty {
                category = categories[indexPath.section]
                item = productsByCategory[category]?[indexPath.item]
            } else {
                item = nil
            }
        }

        cell.descriptionLabel.text = item?.title
        
        if let iconUrl = item?.images[0] {
            cell.loadImage(from: iconUrl)
        }


        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: "HeaderViewIdentifier",
                                                          for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }

        let categories: [String]
        if isSearching {
            categories = Array(filteredProductsByCategory.keys)
        } else {
            categories = Array(productsByCategory.keys)
        }

        let category = categories[indexPath.section]
        headerView.titleLabel.text = category
        return headerView
    }
}
