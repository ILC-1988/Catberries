//
//  ProductView.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

class ProductViewController: UIViewController {

    lazy var searchBar = UISearchBar()
    lazy var collectionView = addCollectionView()
    let collectionDataSource = CollectionDataSource()
    let viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        viewModel.dataClosure = { [weak self] productsByCategory, filteredProductsByCategory, isSearching in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        collectionView.dataSource = viewModel.collectionDataSource
        viewModel.collectionView = collectionView
         viewModel.attach()
    }


    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
