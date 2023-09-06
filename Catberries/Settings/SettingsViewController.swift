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
    lazy var loginOffButton = UIButton.setupButton("Log off")
    lazy var editButton = UIButton.setupButton("Edit")
    lazy var viewCont = UIView()
    lazy var nameTextField = UITextField()
    lazy var emailTextField = UITextField()
    lazy var addressTextField = UITextField()
    lazy var phoneTextField = UITextField()
    lazy var photoImageView = UIImageView()
    var edit = false
    lazy var nameLabel = UILabel()
    lazy var emailLabel = UILabel()
    lazy var addressLabel = UILabel()
    lazy var phoneLabel = UILabel()
    lazy var constraintsEdit = setupConstraintsEdit()
    lazy var constraintsInfo = setupConstraintsInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    deinit {
        print("SettingsViewController deinit")
    }

    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = #colorLiteral(red: 0.8123916293, green: 0.6769403526, blue: 0.8276493033, alpha: 1)
        viewCont.backgroundColor = .systemGray6
        view.addSubview(viewCont)
        viewCont.addSubview(photoImageView)
        viewCont.addSubview(loginOffButton)
        viewCont.addSubview(editButton)

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "person.circle",
                            withConfiguration: configuration)?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        photoImageView.image = image
        loginOffButton.addTarget(self, action: #selector(didTapGoButton(_:)), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(didTapGoEdit(_:)), for: .touchUpInside)
        addHideKeyboard()

        if let currentUser = UserSessionManager.shared.getCurrentUser() {
            setupTextFields(currentUser: currentUser)
            setupLabels(currentUser: currentUser)
        }
    }

    func setupLabels(currentUser: User) {
        setupLabel(label: nameLabel, name: "Name : \(currentUser.name)")
        setupLabel(label: emailLabel, name: "Email : \(currentUser.email ?? "")" )
        setupLabel(label: addressLabel, name: "Address : \(currentUser.address ?? "")" )
        setupLabel(label: phoneLabel, name: "Phone : \(currentUser.phone ?? "")" )
    }

    func setupTextFields(currentUser: User) {
        setupTextField(textField: nameTextField, name: currentUser.name, keyboardType: .default)
        setupTextField(textField: emailTextField, name: currentUser.email ?? "", keyboardType: .emailAddress)
        setupTextField(textField: addressTextField, name: currentUser.address ?? "", keyboardType: .default)
        setupTextField(textField: phoneTextField, name: currentUser.phone ?? "", keyboardType: .phonePad)
    }

    func updateLabels(currentUser: User) {
        nameLabel.text = !edit ? "Name : \(currentUser.name)" : "Name"
        emailLabel.text = !edit ? "Email : \(currentUser.email ?? "")" : "Email"
        addressLabel.text = !edit ? "Address : \(currentUser.address ?? "")" : "Address"
        phoneLabel.text = !edit ? "Phone : \(currentUser.phone ?? "")" : "Phone"
    }

    func updateTextFields(currentUser: User) {
        nameTextField.isHidden = !edit
        emailTextField.isHidden = !edit
        addressTextField.isHidden = !edit
        phoneTextField.isHidden = !edit
    }

    func setConstraints() {
        NSLayoutConstraint.deactivate(constraintsInfo)
        NSLayoutConstraint.deactivate(constraintsEdit)

        viewCont.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false

        if edit {
            NSLayoutConstraint.activate(constraintsEdit)
        } else {
            NSLayoutConstraint.activate(constraintsInfo)
        }

        NSLayoutConstraint.activate([
            viewCont.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewCont.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCont.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewCont.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoImageView.topAnchor.constraint(equalTo: viewCont.topAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            photoImageView.heightAnchor.constraint(equalToConstant: 160),
            photoImageView.widthAnchor.constraint(equalToConstant: 160),
            editButton.topAnchor.constraint(equalTo: viewCont.topAnchor, constant: 8),
            editButton.widthAnchor.constraint(equalToConstant: 80),
            editButton.heightAnchor.constraint(equalToConstant: 32),
            editButton.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            nameLabel.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            emailLabel.bottomAnchor.constraint(equalTo: addressLabel.topAnchor, constant: -8),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            addressLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            phoneLabel.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            loginOffButton.leadingAnchor.constraint(equalTo: viewCont.leadingAnchor, constant: 8),
            loginOffButton.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            loginOffButton.heightAnchor.constraint(equalToConstant: 32),
            loginOffButton.centerXAnchor.constraint(equalTo: viewCont.centerXAnchor),
            loginOffButton.bottomAnchor.constraint(equalTo: viewCont.bottomAnchor, constant: -8)
        ])
    }

    func setupConstraintsEdit() -> [NSLayoutConstraint] {
        return [
            nameLabel.widthAnchor.constraint(equalToConstant: 80),
            emailLabel.widthAnchor.constraint(equalToConstant: 80),
            addressLabel.widthAnchor.constraint(equalToConstant: 80),
            phoneLabel.widthAnchor.constraint(equalToConstant: 80),
            nameLabel.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            emailLabel.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            addressLabel.heightAnchor.constraint(equalTo: addressTextField.heightAnchor),
            phoneLabel.heightAnchor.constraint(equalTo: phoneTextField.heightAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            nameTextField.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            nameTextField.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            addressTextField.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 8),
            addressTextField.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            addressTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 8),
            phoneTextField.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            phoneTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 8)
        ]
    }

    func setupConstraintsInfo() -> [NSLayoutConstraint] {
        return [
            nameLabel.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            emailLabel.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            addressLabel.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8),
            phoneLabel.trailingAnchor.constraint(equalTo: viewCont.trailingAnchor, constant: -8)
        ]
    }

    func setupLabel(label: UILabel, name: String) {
        viewCont.addSubview(label)
        label.text = name
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.backgroundColor = #colorLiteral(red: 0.8276493033, green: 0.781869826, blue: 0.6228453042, alpha: 1)
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupTextField(textField: UITextField, name: String, keyboardType: UIKeyboardType ) {
        textField.borderStyle = .roundedRect
        viewCont.addSubview(textField)
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = 4
        textField.layer.masksToBounds = true
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.text = name
        textField.keyboardType = keyboardType
        textField.delegate = self
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    private func didTapGoButton(_ sender: Any) {
        if let user = UserSessionManager.shared.getCurrentUser() {
            UserSessionManager.shared.setUserInfo(key: user.name, to: user)
        }
        UserSessionManager.shared.clearCurrentUser()
        didSendEventClosure?(.settings)
    }

    @objc
    private func didTapGoEdit(_ sender: Any) {
        if edit {
            edit = false
            editButton.setTitle("Edit", for: .normal)
            let login = nameTextField.text ?? ""
            let user = User(name: login,
                            email: emailTextField.text,
                            address: addressTextField.text,
                            phone: phoneTextField.text)
            UserSessionManager.shared.setUserInfo(key: login, to: user)
            UserSessionManager.shared.setCurrentUser(user: user)
        } else {
            edit = true
            editButton.setTitle("Save", for: .normal)
            nameTextField.isUserInteractionEnabled = false
        }
        loginOffButton.isHidden = edit
        if let currentUser = UserSessionManager.shared.getCurrentUser() {
            updateTextFields(currentUser: currentUser)
            updateLabels(currentUser: currentUser)
        }
        setConstraints()
        viewCont.layoutIfNeeded()
    }
}

extension SettingsViewController {
    enum Event {
        case settings
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
