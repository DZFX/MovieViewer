//
//  LoginViewController.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    let presenter: LoginPresenterProtocol

    lazy var usernameTextField = {
        let field = UITextField()
        field.placeholder = "Email"
        return field
    }()

    lazy var passwordTextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        return field
    }()

    lazy var loginButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        return button
    }()

    lazy var errorLabel = {
        let label = UILabel()
        label.sizeToFit()
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
        super.viewDidLoad()
        setupViews()
        presenter.viewDidLoad(view: self)
    }

    private func setupViews() {
        let contentView = UIStackView()
        contentView.alignment = .center
        contentView.axis = .vertical
        contentView.spacing = 8
        view.addSubview(contentView)
        contentView.centerInSuperview()
        contentView.addArrangedSubview(usernameTextField)
        contentView.addArrangedSubview(passwordTextField)
        contentView.addArrangedSubview(loginButton)
        contentView.addArrangedSubview(errorLabel)
        view.backgroundColor = .systemGray6
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
