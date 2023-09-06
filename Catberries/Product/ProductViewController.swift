//
//  ProductView.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

final class ProductViewController: UIViewController, UISearchBarDelegate {

    lazy var searchBar = makeSearchBar()
    lazy var collectionView = makeCollectionView()
    let viewModel = ProductViewModel()
    var addToCartClosure: ((Product) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initViewModel()
        viewModel.attach()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    deinit {
        print("ProductViewController deinit")
    }
}
