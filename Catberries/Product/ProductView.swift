//
//  ProductView.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

final class ProductViewController: UIViewController {

    lazy var searchBar = makeSearchBar()
    lazy var collectionView = makeCollectionView()
    let viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initViewModel()
        viewModel.attach()
    }
}
