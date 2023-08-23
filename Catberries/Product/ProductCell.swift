//
//  ViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

protocol ProductCellDelegate: class {
    func addToCart(for product: Product)
}

final class ProductCell: UICollectionViewCell {

    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let brandLabel = UILabel()
    let imageView = UIImageView()
    let addToCartButton = UIButton(type: .system)
    var addToCartClosure: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont(name: "Kefa Regular", size: 12)

        priceLabel.textAlignment = .left
        if let font = UIFont(name: "Marker Felt", size: 16) {
            let boldFont = UIFont.systemFont(ofSize: font.pointSize, weight: .bold)
            priceLabel.font = boldFont
        }

        brandLabel.textAlignment = .left
        if let font = UIFont(name: "Kefa Regular", size: 12) {
            let boldFont = UIFont.systemFont(ofSize: font.pointSize, weight: .bold)
            brandLabel.font = boldFont
        }

        imageView.layer.borderColor =  #colorLiteral(red: 0.6830508832, green: 0.6700330661, blue: 0.507898741, alpha: 1).cgColor
        imageView.layer.borderWidth = 0.5
        imageView.image = UIImage(named: "icon-Logo")
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "cart",
                            withConfiguration: configuration)?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)

        addToCartButton.setImage(image, for: .normal)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        contentView.addSubview(addToCartButton)
        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(brandLabel)
        addSubview(descriptionLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.05
        imageView.clipsToBounds = true
    }

    func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            imageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -4),

            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            priceLabel.bottomAnchor.constraint(equalTo: brandLabel.topAnchor),

            addToCartButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            addToCartButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),

            brandLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            brandLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            brandLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc func addToCartButtonTapped() {
        self.addToCartClosure?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
