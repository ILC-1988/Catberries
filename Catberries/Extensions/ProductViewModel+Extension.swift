//
//  ProductViewModel+Extension.swift
//  Catberries
//
//  Created by Илья Черницкий on 2.08.23.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductViewModel: UICollectionViewDelegateFlowLayout {

    private var columnNumber: CGFloat { 5 }
    private var sectionInsets: UIEdgeInsets { .zero }
    private var cellSpacing: CGFloat { 4 }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProductCell {
            cellTapped(cell.textLabel, indexPath: indexPath)
        }
        print("Selected item at index: \(indexPath.item)")
    }

    func cellTapped(_ sender: UILabel, indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            sender.textColor = .yellow
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

        return CGSize(width: collectionView.frame.width, height: 24)
    }
}

// MARK: - UISearchBarDelegate
extension ProductViewModel: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.attach()
        } else {
            let filteredProductsByCategory = collectionDataSource.searchProductsByValue(searchText)
            self.updateData(with: productsByCategory,
                             filteredProductsByCategory: filteredProductsByCategory,
                             isSearching: true)
            self.collectionView?.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.attach()
    }

}
