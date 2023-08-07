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
        titleLabel.textColor = .black
        titleLabel.frame = self.bounds
        titleLabel.font = UIFont(name: "Marker Felt Thin", size: 18)
        addSubview(titleLabel)
        //self.backgroundColor = .clear
        self.setElementAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
