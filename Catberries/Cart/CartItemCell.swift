//
//  CartItemCell.swift
//  Catberries
//
//  Created by Илья Черницкий on 23.08.23.
//

import UIKit

protocol CartItemCellDelegate: AnyObject {
    func didTapButton(in cell: CartItemCell, add: Bool)
}

class CartItemCell: UITableViewCell {
    static let reuseIdentifier = "CartItemCell"
    weak var delegate: CartItemCellDelegate?

    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addButton: UIButton = .setupButton("+")
    private let subtractButton: UIButton = .setupButton("-")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(customImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(totalLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(subtractButton)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        subtractButton.addTarget(self, action: #selector(subtractButtonTapped(_:)), for: .touchUpInside)
        setConstraints()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customImageView.widthAnchor.constraint(equalToConstant: 60),
            customImageView.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            subtractButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            subtractButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 8),
            subtractButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subtractButton.widthAnchor.constraint(equalToConstant: 30),
            subtractButton.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            quantityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            quantityLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            totalLabel.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            totalLabel.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 8),
            totalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            totalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with cartItem: UserData) {
        if let iconUrl = URL(string: cartItem.product.thumbnail) {
            customImageView.setImage(iconUrl)
        }
        nameLabel.text = cartItem.product.title
        priceLabel.text = "Price: $\(cartItem.product.price.format())"
        quantityLabel.text = "Quantity: \(cartItem.quantity)"
        let price = cartItem.product.price * cartItem.quantity
        totalLabel.text = "Total: $\(price.format())"
    }

    @objc
    func addButtonTapped(_ sender: UIButton) {
        delegate?.didTapButton(in: self, add: true)
    }

    @objc
    func subtractButtonTapped(_ sender: UIButton) {
        delegate?.didTapButton(in: self, add: false)
    }

}
