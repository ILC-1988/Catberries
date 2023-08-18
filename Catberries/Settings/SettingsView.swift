//
//  ProductInfoView.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

final class SettingsViewController: UIViewController {

    var viewModel = SettingsViewModel()
    var didSendEventClosure: ((SettingsViewController.Event) -> Void)?

    private let goButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login off", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(goButton)

        goButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goButton.widthAnchor.constraint(equalToConstant: 200),
            goButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        goButton.addTarget(self, action: #selector(didTapGoButton(_:)), for: .touchUpInside)
    }

    deinit {
        print("SettingsViewController deinit")
    }

    @objc private func didTapGoButton(_ sender: Any) {
        didSendEventClosure?(.settings)
    }
}

extension SettingsViewController {
    enum Event {
        case settings
    }
}
