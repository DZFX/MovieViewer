//
//  LoginViewController.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import UIKit

class LoginViewController: ViewController {
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
        field.delegate = self
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
        field.delegate = self
        field.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return field
    }()

    lazy var loginButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .small
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14, weight: .medium)
            return outgoing
          }
        config.baseBackgroundColor = .systemGreen
        config.title = "Log in"
        
      button.configurationUpdateHandler = { [weak self] button in
          guard let self = self else { return }
          var config = button.configuration
          config?.showsActivityIndicator = self.presenter.isLoggingIn
          config?.title = self.presenter.isLoggingIn ? "Logging in..." : "Log in"
          button.isEnabled = !self.presenter.isLoggingIn
          button.configuration = config
        }
        button.configuration = config
        button.setHeightConstraint(constant: 45)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()

    lazy var errorLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .red
        label.font = .systemFont(ofSize: 11)
        label.sizeToFit()
        label.setHeightConstraint(constant: 35)
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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        contentView.centerInSuperview()
        contentView.addHorizontalPaddingWithSuperview(offset: 5)
        contentView.backgroundColor = .clear
        contentView.alignment = .center
        contentView.axis = .vertical
        contentView.spacing = 15
        contentView.distribution = .fillProportionally
        contentView.addArrangedSubview(logoImageView)
        contentView.addArrangedSubview(usernameTextField)
        usernameTextField.addHorizontalPaddingWithSuperview(offset: 35)
        contentView.addArrangedSubview(passwordTextField)
        passwordTextField.addHorizontalPaddingWithSuperview(offset: 35)
        contentView.addArrangedSubview(loginButton)
        loginButton.addHorizontalPaddingWithSuperview(offset: 35)
        contentView.addArrangedSubview(errorLabel)
        errorLabel.addHorizontalPaddingWithSuperview()
        contentView.sizeToFit()
    }

    @objc func textFieldDidChange(textField: UITextField) {
        presenter.updateCredentials(username: usernameTextField.text, password: passwordTextField.text)
    }

    @objc func didTapLogin() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        loginButton.setNeedsUpdateConfiguration()
        presenter.performLogin()
    }
}

extension LoginViewController: LoginViewProtocol {
    func loaded(username: String) {
        usernameTextField.text = username
    }
    
    func finishedLogin(with error: Error?) {
        loginButton.setNeedsUpdateConfiguration()
        errorLabel.text = error?.localizedDescription
        presenter.goToMainGrid()
    }

    func updateLoginStatus(enabled: Bool) {
        loginButton.isEnabled = enabled
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapLogin()
        }
        return true
    }
}
