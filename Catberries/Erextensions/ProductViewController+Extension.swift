//
//  Erextensions.swift
//  Catberries
//
//  Created by Илья Черницкий on 29.07.23.
//

import UIKit

extension ProductViewController {
    
    func addCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        view.setupConstraints(for: collectionView, in: view, with: UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8))

    }
    
}

// MARK: - UICollectionViewDataSource
extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
    private var columnNumber: CGFloat { 5 }
    private var sectionInsets: UIEdgeInsets { .zero }
    private var cellSpacing: CGFloat { 4 }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at index: \(indexPath.item)")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let edgeSize = (collectionView.bounds.width - (sectionInsets.left + sectionInsets.right + cellSpacing * (columnNumber - 1))) / columnNumber
        
        return CGSize(width: edgeSize, height: edgeSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
}
