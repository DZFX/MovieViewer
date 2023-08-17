//
//  LoginViewController.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    let presenter: LoginPresenterProtocol

    lazy var logoImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo")
        imageView.image = image
        imageView.setWidthConstraint(constant: 90)
        imageView.setHeightConstraint(constant: 80)
        return imageView
    }()

    lazy var usernameTextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Username"
        field.setHeightConstraint(constant: 45)
        field.sizeToFit()
        field.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(textField:)), for: .editingChanged)
        return field
    }()

    lazy var passwordTextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.setHeightConstraint(constant: 45)
        field.sizeToFit()
        field.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return field
    }()

    lazy var loginButton = {
        let button = ReactiveButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 2.0
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitle("Log in", for: .normal)
        button.setHeightConstraint(constant: 45)
        button.sizeToFit()
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()

    lazy var errorLabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        label.setHeightConstraint(constant: 25)
        return label
    }()

    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        print("Loadede LoginViewController")
        super.viewDidLoad()
        setupViews()
        presenter.viewDidLoad(view: self)
    }

    private func setupViews() {
        let contentView = UIStackView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        contentView.centerInSuperview()
        contentView.addHorizontalPaddingWithSuperview(offset: 40)
        contentView.backgroundColor = .clear
        contentView.alignment = .center
        contentView.axis = .vertical
        contentView.spacing = 15
        contentView.distribution = .fillProportionally
        contentView.addArrangedSubview(logoImageView)
        contentView.addArrangedSubview(usernameTextField)
        usernameTextField.addHorizontalPaddingWithSuperview()
        contentView.addArrangedSubview(passwordTextField)
        passwordTextField.addHorizontalPaddingWithSuperview()
        contentView.addArrangedSubview(loginButton)
        loginButton.addHorizontalPaddingWithSuperview()
        contentView.addArrangedSubview(errorLabel)
        errorLabel.addHorizontalPaddingWithSuperview()
        contentView.sizeToFit()
        let gradientLayer = AppColors.backgroundGradient
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @objc func textFieldDidChange(textField: UITextField) {
        presenter.updateCredentials(username: usernameTextField.text, password: passwordTextField.text)
    }

    @objc func didTapLogin() {
        loginButton.setNeedsUpdateConfiguration()
        presenter.performLogin()
    }
}

extension LoginViewController: LoginViewProtocol {
    func loaded(username: String) {
        usernameTextField.text = username
    }
    
    func finishedLogin(with error: Error?) {
        errorLabel.text = error?.localizedDescription
    }

    func updateLoginStatus(enabled: Bool) {
        loginButton.isEnabled = enabled
    }
}
