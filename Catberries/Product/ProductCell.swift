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
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(descriptionLabel)
        
        priceLabel.textAlignment = .left
        priceLabel.font = UIFont.systemFont(ofSize: 18)
        addSubview(priceLabel)
        
        addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.10

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
