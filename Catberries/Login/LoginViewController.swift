//
//  LoginViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

class LoginViewController: UIViewController {

    var didSendEventClosure: ((LoginViewController.Event) -> Void)?
    private var userDictionary: [String: String] = [:]
    lazy var loginButton = setupLoginButton("Sing In")
    lazy var createButton = setupLoginButton("Sing up")
    lazy var imageView = setupImage()
    private var input = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        loginButton.addTarget(self, action: #selector(singIn(_:)), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(singUp(_:)), for: .touchUpInside)
        setConstraints()
    }

    func setConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -16),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            loginButton.heightAnchor.constraint(equalToConstant: 32),

            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            createButton.heightAnchor.constraint(equalToConstant: 32),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupLoginButton(_ name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont(name: "Marker Felt", size: 24)
        button.setTitleColor(.darkGray, for: .normal)
        view.addSubview(button)
        return button
    }

    private func setupImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "icon-Logo"))
        view.addSubview(imageView)
        return imageView
    }

    @objc
    private func singIn(_ sender: Any) {
        let inputAlert = UIAlertController(title: "Sing in",
                                           message: "Enter login and password",
                                           preferredStyle: .alert)
        inputAlert.addAction(
            UIAlertAction(title: "Cancel",
                          style: .cancel ))
        let okAction = UIAlertAction(
            title: "OK",
            style: .default ) { [weak self] _ in
                if let textFieldsArray = inputAlert.textFields,
                   let login = textFieldsArray[0].text,
                   let password = textFieldsArray[1].text {
                    var userSingIn = self?.userSingIn(login: login, password: password)
                    if userSingIn == true {
                        self?.didSendEventClosure?(.login)
                        self?.showInputUser(login)
                        self?.input = true
                    }
                    else {
                        self?.showError(login)
                        self?.input = false
                    }
                }
            }
        okAction.isEnabled = false
        inputAlert.addAction(okAction)
        inputAlert.addTextField { textField in
            textField.placeholder = "Login"
            validate(textField)
        }
        inputAlert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            validate(textField)
        }

        func validate(_ textField: UITextField) {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main) { _ in
                    let loginText = inputAlert.textFields![0].text
                    let passwordText = inputAlert.textFields![1].text
                    if let loginText = loginText,
                       !loginText.isEmpty,
                       let passwordText = passwordText,
                       !passwordText.isEmpty {
                        okAction.isEnabled = true
                    } else {
                        okAction.isEnabled = false
                    }
                }
        }
        present(inputAlert, animated: true)
    }

    @objc
    private func singUp(_ sender: Any) {
        let inputAlert = UIAlertController(title: "Sing up",
                                           message: "Create new account",
                                           preferredStyle: .alert)

       inputAlert.addAction(
            UIAlertAction(title: "Cancel",
                          style: .cancel ))

        let okAction = UIAlertAction(
            title: "OK",
            style: .default ) { _ in
                if let textFieldsArray = inputAlert.textFields,
                   let login = textFieldsArray[0].text,
                   let password = textFieldsArray[1].text {
                    self.showNewUser(login)
                    self.userDictionary[login] = password
                }

            }

        okAction.isEnabled = false

        inputAlert.addAction(okAction)

        inputAlert.addTextField { textField in
            textField.placeholder = "Login"
            validate(textField)
        }

        inputAlert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            validate(textField)
        }

        inputAlert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.rightViewMode = .always
            validate(textField)
        }

        func validate(_ textField: UITextField) {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main) { _ in
                    let loginText = inputAlert.textFields![0].text
                    let passwordText = inputAlert.textFields![1].text
                    let passwordAgainText = inputAlert.textFields![2].text

                    if let loginText = loginText,
                       !loginText.isEmpty,
                       let passwordText = passwordText,
                       passwordText == passwordAgainText,
                       !passwordText.isEmpty {

                        okAction.isEnabled = true
                    } else {
                        okAction.isEnabled = false
                    }
                }
        }

        present(inputAlert, animated: true)
    }

    private func userSingIn(login: String, password: String) -> Bool {

        var input = false
        for (user, pass) in userDictionary {
            if user == login {
                input = pass == password
                break
            }
        }
        return input
    }
}
