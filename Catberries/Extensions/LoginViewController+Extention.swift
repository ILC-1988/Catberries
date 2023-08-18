//
//  LoginViewController+Extention.swift
//  Catberries
//
//  Created by Илья Черницкий on 18.08.23.
//

import UIKit

// MARK: UIAlert
extension LoginViewController {
    func showNewUser(_ user: String) {
     let errorAlert = UIAlertController(
        title: "Catberries success",
        message: "New user \(user)",
        preferredStyle: .alert)

        errorAlert.addAction(
            UIAlertAction(title: "OK",
                          style: .default)
        )

        present(errorAlert, animated: true)
    }

    func showInputUser(_ user: String) {
     let errorAlert = UIAlertController(
        title: "Catberries",
        message: "Welcome \(user)",
        preferredStyle: .alert)

        errorAlert.addAction(
            UIAlertAction(title: "OK",
                          style: .default)
        )

        present(errorAlert, animated: true)
    }

    func showError(_ user: String) {
     let errorAlert = UIAlertController(
        title: "Catberries error",
        message: "incorrect login or password",
        preferredStyle: .alert)

        errorAlert.addAction(
            UIAlertAction(title: "OK",
                          style: .default)
        )

        present(errorAlert, animated: true)
    }
}
