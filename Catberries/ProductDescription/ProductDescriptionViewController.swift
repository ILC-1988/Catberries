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
    lazy var viewCont = UIView()
    lazy var addCartButton = UIButton.setupButton("Add cart")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        addCartButton.addTarget(self, action: #selector(didTapGoButton(_:)), for: .touchUpInside)
        addCartButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        addCartButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
        viewCont.addSubview(addCartButton)
        view.backgroundColor = #colorLiteral(red: 0.8123916293, green: 0.6769403526, blue: 0.8276493033, alpha: 1)
        viewCont.backgroundColor = .systemGray6
        view.addSubview(viewCont)
        title = product?.title
        imageNames = product?.images ?? []
        addImagesToScrollView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    private func setConstraints() {
        viewCont.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewCont.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            viewCont.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCont.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewCont.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        return scrollView
    }

    private func setupPageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.backgroundStyle = .prominent
        return pageControl
    }

    private func addImagesToScrollView() {
        if let imageNames = product?.images as? [String] {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false

            scrollView.addSubview(stackView)
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true

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

            viewCont.addSubview(scrollView)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

            pageControl.translatesAutoresizingMaskIntoConstraints = false
            viewCont.addSubview(pageControl)
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20).isActive = true

            addCartButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                addCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                addCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                addCartButton.heightAnchor.constraint(equalToConstant: 32),
                addCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                addCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])

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
