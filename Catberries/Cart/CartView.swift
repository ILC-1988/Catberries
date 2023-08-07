//
//  BasketView.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

final class CartViewController: UIViewController {

    var viewModel = CartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        toolbar.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }

}
