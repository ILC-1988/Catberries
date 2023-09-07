//
//  BasketView.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

final class CartViewController: UIViewController {

    var viewModel = CartViewModel()
    var tableView = UITableView()
    let screenshotImageView = UIImageView()

    lazy var buyButton = UIButton.setupButton("Enter and oder")

    lazy var viewCont = UIView()

    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        print("CartViewController deinit")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.cartDelegate = self
        self.navigationController?.isNavigationBarHidden = true
        buyButton.addTarget(self, action: #selector(didTapGoButton(_:)), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)

        viewModel.fetchCartItems()
        view.backgroundColor = #colorLiteral(red: 0.8123916293, green: 0.6769403526, blue: 0.8276493033, alpha: 1)

        viewCont.backgroundColor = .systemGray6
        view.addSubview(viewCont)

        tableView.backgroundColor = .systemGray6
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.separatorColor = #colorLiteral(red: 0.6830508832, green: 0.6700330661, blue: 0.507898741, alpha: 1)
        tableView.tableHeaderView = HeaderView()
        viewCont.addSubview(tableView)
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
        tableView.register(CartHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.reloadData()
        viewCont.addSubview(buyButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCart()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    private func setConstraints() {
        viewCont.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            viewCont.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            viewCont.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCont.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewCont.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: viewCont.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor),

            buyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            buyButton.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            buyButton.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            buyButton.heightAnchor.constraint(equalToConstant: 32),
            buyButton.centerXAnchor.constraint(equalTo: viewCont.centerXAnchor),
            buyButton.bottomAnchor.constraint(equalTo: viewCont.bottomAnchor, constant: -8)
        ])
    }

    func updateCart() {
        self.buyButton.isHidden = viewModel.cartItems.isEmpty
        updateTotalAmount()
        tableView.reloadData()
    }

    func updateTotalAmount() {
        let total = viewModel.calculateTotal().format()
        buyButton.setTitle("Enter and oder: \(total) $", for: .normal)
    }

    @objc
    private func didTapGoButton(_ sender: Any) {
        takeScreenshotAndAnimate()
        viewModel.clearCart()
        tableView.reloadData()
    }

    @objc
    func buttonReleased() {
        UIView.animate(withDuration: 0.4) {
            self.buyButton.isHidden = true
        }
    }

    func takeScreenshotAndAnimate() {
        guard let screenshot = takeScreenshot() else { return }

        screenshotImageView.image = screenshot
        screenshotImageView.frame = CGRect(x: 0, y: 0, width: screenshot.size.width, height: screenshot.size.height)
        view.addSubview(screenshotImageView)

        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.screenshotImageView.frame.origin.x = self.view.frame.width
        }, completion: { (_) in
            self.screenshotImageView.removeFromSuperview()
        })
    }

    func takeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot
    }
}
