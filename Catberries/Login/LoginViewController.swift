//
//  LoginViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

class LoginViewController: UIViewController {

    var didSendEventClosure: ((LoginViewController.Event) -> Void)?
    lazy var loginButton = setupLoginButton("Sing In")
    lazy var createButton = setupLoginButton("Sing up")
    lazy var imageView = setupImage()
    lazy var logoLabel =  setupLogoLabel()
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadCredentials()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        loginButton.addTarget(self, action: #selector(singIn(_:)), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(singUp(_:)), for: .touchUpInside)
    }

    func setConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            loginButton.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -16),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            loginButton.heightAnchor.constraint(equalToConstant: 32),

            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            createButton.heightAnchor.constraint(equalToConstant: 32),

            logoLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -24),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupLoginButton(_ name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Marker Felt", size: 24)
        let coller = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.setTitleColor( coller, for: .normal)
        view.addSubview(button)
        return button
    }

    private func setupImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "icon-Logo"))
        view.addSubview(imageView)
        return imageView
    }

    private func setupLogoLabel() -> UILabel {
        let logoLabel = UILabel()
        logoLabel.text = "Welcome to Catberries"
        logoLabel.textAlignment = .center
        logoLabel.textColor = #colorLiteral(red: 0.7758546472, green: 0.6073476271, blue: 0.731810549, alpha: 1)
        logoLabel.font = UIFont(name: "Marker Felt", size: 36)
        view.addSubview(logoLabel)
        return logoLabel
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
                    let userSingIn = self?.viewModel.userSingIn(login: login, password: password)
                    if userSingIn == true {
                        if let user = UserSessionManager.shared.getUserInfo(key: login) {
                            UserSessionManager.shared.setCurrentUser(user: user)
                            self?.didSendEventClosure?(.login)
                            self?.showInputUser(login)
                        } else {
                            UserSessionManager.shared.clearCurrentUser()
                            self?.showError(login)
                        }
                    } else {
                        UserSessionManager.shared.clearCurrentUser()
                        self?.showError(login)
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
            style: .default ) { [weak self] _ in
                if let textFieldsArray = inputAlert.textFields,
                   let login = textFieldsArray[0].text,
                   let password = textFieldsArray[1].text {
                    let user = User(name: login,
                                    email: "\(login)@example.com",
                                    address: "123 Minsk St",
                                    phone: nil)
                    UserSessionManager.shared.setUserInfo(key: login, to: user)
                    self?.showNewUser(login)
                    self?.viewModel.userDictionary[login] = password
                    self?.viewModel.saveCredentials()
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
}
