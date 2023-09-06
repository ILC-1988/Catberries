//
//  Erextensions.swift
//  Catberries
//
//  Created by Илья Черницкий on 29.07.23.
//

import UIKit

extension ProductViewController {

   func makeCollectionView() -> UICollectionView {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .primaryActionTriggered)
        collectionView.refreshControl = refreshControl

        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel.collectionDataSource
        viewModel.collectionDataSource.delegate = self

        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderViewIdentifier")

       collectionView.backgroundColor = .systemGray6
        view.addSubview(collectionView)
        return collectionView
    }

    @objc
    private func handlePullToRefresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.endRefreshing()
            self.viewModel.attach()
        }
    }

    func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = viewModel

        let font = UIFont(name: "Kefa Regular", size: 16)
        let attributedPlaceholder = NSAttributedString(
            string: "Search on Catberries",
            attributes: [NSAttributedString.Key.font: font]
        )

        searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 16
        let closeButton = UIBarButtonItem(title: "Close",
                                           style: .done,
                                           target: self,
                                           action: #selector(closeButtonTapped))
        toolbar.items = [flexibleSpace, closeButton, fixedSpace]
        searchBar.inputAccessoryView = toolbar
        view.addSubview(searchBar)
        return searchBar
    }

    @objc
    func closeButtonTapped() {
        searchBar.resignFirstResponder()
    }

    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.8123916293, green: 0.6769403526, blue: 0.8276493033, alpha: 1)
    }

    func setConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func initViewModel() {
        viewModel.dataClosure = { [weak self] products, filteredProducts, isSearching in
            DispatchQueue.main.async {
                self?.viewModel.collectionDataSource.productsByCategory = products
                self?.viewModel.collectionDataSource.filteredProductsByCategory = filteredProducts
                self?.viewModel.collectionDataSource.isSearching = isSearching
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - CollectionDataSourceDelegate
extension ProductViewController: CollectionDataSourceDelegate {
    func addToCartButtonTapped(for product: Product) {
        addToCartClosure?(product)
    }
}
