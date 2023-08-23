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
        titleLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        titleLabel.frame = self.bounds
        titleLabel.font = UIFont(name: "Marker Felt Thin", size: 24)
        addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
