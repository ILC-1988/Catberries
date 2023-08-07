//
//  ViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import Alamofire
import UIKit

final class ProductCell: UICollectionViewCell {
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let brandLabel = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

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

        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(brandLabel)
        addSubview(descriptionLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setConstraints()

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.025
        imageView.clipsToBounds = true
    }

    func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: brandLabel.topAnchor),

            brandLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            brandLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadImage(from urlString: String) {
        if let url = URL(string: urlString) {
            AF.request(url).responseData { response in
                if let data = response.data, let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         self.imageView.image = image
                     }
                }
            }
        }
    }

}
