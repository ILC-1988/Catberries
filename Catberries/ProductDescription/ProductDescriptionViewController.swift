//
//  ProductDescriptionViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 9.08.23.
//

import UIKit

class ProductDescriptionViewController: UIViewController {

    var product: Product?
    var imageNames: [String] = []
    var addToCartClosure: ((ProductDescriptionViewController.Event) -> Void)?

    lazy var scrollView: UIScrollView = {
        return setupUIScrollView()
    }()

    lazy var pageControl: UIPageControl = {
        return setupPageControl()
    }()

    lazy var multiLineLabel: UILabel = {
        return setupMultiLineLabel()
    }()

    lazy var stackView: UIStackView = {
        return setupStackView()
    }()

    lazy var viewCont = UIView()
    lazy var addCartButton = UIButton.setupButton("Add cart")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        addCartButton.addTarget(self, action: #selector(didTapGoButton(_:)), for: .touchUpInside)
        addCartButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        addCartButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
        view.addSubview(viewCont)
        viewCont.addSubview(scrollView)
        scrollView.addSubview(stackView)
        viewCont.addSubview(addCartButton)
        viewCont.addSubview(pageControl)
        viewCont.addSubview(multiLineLabel)
        view.backgroundColor = #colorLiteral(red: 0.8123916293, green: 0.6769403526, blue: 0.8276493033, alpha: 1)
        viewCont.backgroundColor = .systemGray6
        title = product?.title
        imageNames = product?.images ?? []
        addImagesToScrollView()
        let price = "0.0 $"
        if let priceStr = product?.price.format() {
            let price = priceStr + " $"
        }
        multiLineLabel.text = "Category: \(product?.category ?? "")\n" +
                              "Description: \(product?.description ?? "")\n" +
                              "Price: \(String(price))\n" +
                              "Discount: \((product?.discountPercentage ?? 0) * 100)%\n" +
                              "Rating: \(product?.rating ?? 0.0)\n" +
                              "Stock: \(product?.stock ?? 0)\n" +
                              "Brand: \(product?.brand ?? "")"

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    private func setConstraints() {
        viewCont.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewCont.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewCont.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewCont.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewCont.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            scrollView.topAnchor.constraint(equalTo: viewCont.topAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            multiLineLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8),
            multiLineLabel.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            multiLineLabel.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            multiLineLabel.bottomAnchor.constraint(equalTo: addCartButton.topAnchor, constant: -8),
            addCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            addCartButton.heightAnchor.constraint(equalToConstant: 32),
            addCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
    }

    deinit {
        print("ProductDescriptionViewController deinit")
    }

    @objc
    private func didTapGoButton(_ sender: Any) {
        UIView.animate(withDuration: 0.4) {
                self.addCartButton.backgroundColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
        addToCartClosure?(.addCart)
    }

    @objc
    func buttonReleased() {
        UIView.animate(withDuration: 0.4) {
                    self.addCartButton.backgroundColor = #colorLiteral(red: 0.8123916293, green: 0.6769403526, blue: 0.8276493033, alpha: 1)
                }
    }

    private func setupUIScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }

    private func setupPageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.backgroundStyle = .prominent
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }

    private func setupMultiLineLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.backgroundColor = #colorLiteral(red: 0.7293315735, green: 0.8276493033, blue: 0.7071431792, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }

    private func setupStackView() -> UIStackView {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.spacing = 0
         stackView.distribution = .fillEqually
         stackView.alignment = .fill
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
    }

    private func addImagesToScrollView() {
        if let imageNames = product?.images as? [String] {
            for imageName in imageNames {
                let imageView = UIImageView()
                if let iconUrl = URL(string: imageName) {
                    imageView.setImage(iconUrl)
                    imageView.contentMode = .scaleAspectFit
                    stackView.addArrangedSubview(imageView)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
                    imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
                }
            }
            updateCurrentPage(page: 0)
        }
    }

    private func updateCurrentPage(page: Int) {
        pageControl.currentPage = page
    }
}

extension ProductDescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
        updateCurrentPage(page: currentPage)
    }
}

extension ProductDescriptionViewController {
    enum Event {
        case addCart
    }
}
