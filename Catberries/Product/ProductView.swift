//
//  ProductView.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//


import UIKit

final class ProductViewController: UIViewController, UICollectionViewDelegate {
    
    let viewModel = ProductViewModel()
    var isSearching: Bool = false
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    
}
