//
//  ProductHeader.swift
//  Catberries
//
//  Created by Илья Черницкий on 7.08.23.
//

import UIKit

class HeaderView: UICollectionReusableView {
    let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.frame = self.bounds
        addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}