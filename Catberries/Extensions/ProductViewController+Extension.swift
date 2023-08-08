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
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderViewIdentifier")

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
        view.addSubview(searchBar)
        return searchBar
    }

    func makeToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        view.addSubview(toolbar)
        return toolbar
    }

    func setupUI() {
        view.backgroundColor = .systemPurple
        setupConstraints()
    }

    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false

        toolbar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
