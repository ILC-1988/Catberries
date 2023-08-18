//
//  ProductDescriptionViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 9.08.23.
//

import UIKit

class ProductDescriptionViewController: UIViewController {

    var product: Product?
    var didSendEventClosure: ((ProductDescriptionViewController.Event) -> Void)?

    private let goButton: UIButton = {
        let button = UIButton()
        button.setTitle("back", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        print(product)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Description"
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem?.tintColor = .purple
    }

    deinit {
        print("ProductDescriptionViewController deinit")
    }

    @objc private func didTapGoButton(_ sender: Any) {
        didSendEventClosure?(.description)
    }
}

extension ProductDescriptionViewController {
    enum Event {
        case description
    }
}
