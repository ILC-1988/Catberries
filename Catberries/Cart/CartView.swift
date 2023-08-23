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

    lazy var buy: UIButton = {
        let button = UIButton()
        button.setTitle("buy", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(didTapGoButton(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
        return button
    }()
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
        viewCont.addSubview(buy)
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCart()
    }

    private func setConstraints() {
        viewCont.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        buy.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            viewCont.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewCont.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCont.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewCont.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: viewCont.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor),

            buy.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            buy.widthAnchor.constraint(equalToConstant: 200),
            buy.heightAnchor.constraint(equalToConstant: 50),
            buy.centerXAnchor.constraint(equalTo: viewCont.centerXAnchor),
            buy.bottomAnchor.constraint(equalTo: viewCont.bottomAnchor, constant: -8)
        ])
    }

    func updateCart() {
        tableView.reloadData()
        buy.isEnabled = !viewModel.cartItems.isEmpty
    }

    @objc
    private func didTapGoButton(_ sender: Any) {
        UIView.animate(withDuration: 0.4) {
            self.buy.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }
        takeScreenshotAndAnimate()
        viewModel.clearCart()
        tableView.reloadData()
        buy.isEnabled = false
    }

    @objc
    func buttonReleased() {
        UIView.animate(withDuration: 0.4) {
            self.buy.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
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
