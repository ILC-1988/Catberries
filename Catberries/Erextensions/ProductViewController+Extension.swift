//
//  Erextensions.swift
//  Catberries
//
//  Created by Илья Черницкий on 29.07.23.
//

import UIKit

extension ProductViewController {

    func setupView() {

        view.backgroundColor = .white
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        let toolbar = UIToolbar()

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true

        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        toolbar.heightAnchor.constraint(equalToConstant: 10).isActive = true

    }

}

// MARK: - UICollectionViewDataSource
extension ProductViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return viewModel.filteredItems.count
        } else {
            return viewModel.items.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if let cell = cell as? ProductCell {
            let item: Item
            if isSearching {
                item = viewModel.filteredItems[indexPath.row]
            } else {
                item = viewModel.items[indexPath.row]
            }
            cell.textLabel.text = item.name
       }
        return cell
   }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductViewController: UICollectionViewDelegateFlowLayout {

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
}

// MARK: - UISearchBarDelegate
extension ProductViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            collectionView.reloadData()
        } else {
            isSearching = true
            viewModel.filterItems(with: searchText)
            collectionView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        collectionView.reloadData()
    }

}
