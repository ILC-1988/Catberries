//
//  ProductViewModel+Extension.swift
//  Catberries
//
//  Created by Илья Черницкий on 2.08.23.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductViewModel: UICollectionViewDelegateFlowLayout {

    private var columnNumber: CGFloat { 2 }
    private var sectionInsets: UIEdgeInsets { .zero }
    private var cellSpacing: CGFloat { 8 }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProductCell {
            cellTapped(cell.descriptionLabel, indexPath: indexPath)
        }

        let categories: [String]
        let category: String

        categories = Array(self.collectionDataSource.productsByCategory.keys)
        if !categories.isEmpty {
            category = categories[indexPath.section]
            if let product = self.collectionDataSource.productsByCategory[category]?[indexPath.item] as? Product {
                delegate?.didSelectCell(at: product)
            }
        }
    }

    func cellTapped(_ sender: UILabel, indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            sender.textColor = .purple
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                sender.transform = CGAffineTransform.identity
                sender.textColor = .black
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    let edgeSize = (collectionView.bounds.width - (sectionInsets.left + sectionInsets.right + cellSpacing
                                                       * (columnNumber - 1))) / columnNumber
        return CGSize(width: edgeSize, height: edgeSize)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {

        collectionView.collectionViewLayout.invalidateLayout()

        return CGSize(width: collectionView.frame.width, height: 32)
    }
}

// MARK: - UISearchBarDelegate
extension ProductViewModel: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.dataClosure?(collectionDataSource.productsByCategory, [:], false)
        } else {
            let filteredProductsByCategory = collectionDataSource.searchProductsByValue(searchText)
            self.dataClosure?(collectionDataSource.productsByCategory, filteredProductsByCategory, true)
        }
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        self.dataClosure?(collectionDataSource.productsByCategory, [:], false)
    }
}
