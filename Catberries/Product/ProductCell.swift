//
//  ViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(textLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
