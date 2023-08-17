//
//  LoginPresenter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 15/08/23.
//

import Foundation

enum LoginStatus {
    case notLoggedIn
    case loggingIn
    case loggedIn
    case loginFailed(Error)

    var isLoggedIn: Bool {
        if case .loggedIn = self {
            return true
        }
        return false
    }

    var hadError: Bool {
        if case .loginFailed = self {
            return true
        }
        return false
    }

    var isLoggingIn: Bool {
        if case .loggingIn = self {
            return true
        }
        return false
    }
}

class LoginPresenter {
    var loginStatus: LoginStatus = .notLoggedIn
    let loginInteractor: LoginInteractorInputProtocol
    var isLoggingIn: Bool { loginStatus.isLoggingIn}
    weak var view: LoginViewProtocol?

    init(loginStatus: LoginStatus, loginInteractor: LoginInteractorInputProtocol) {
        self.loginStatus = loginStatus
        self.loginInteractor = loginInteractor
    }

    func performLogin() {
        loginStatus = .loggingIn
        loginInteractor.performLogin()
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func updateLoginStatus(enabled: Bool) {
        view?.updateLoginStatus(enabled: enabled)
    }
    
    func loginSucceeded() {
        guaranteeMainThread { [weak self] in
            self?.loginStatus = .loggedIn
            self?.view?.finishedLogin(with: nil)
        }
    }
    
    func loginFailed(with error: Error) {
        guaranteeMainThread { [weak self] in
            self?.loginStatus = .loginFailed(error)
            self?.view?.finishedLogin(with: error)
        }
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func updateCredentials(username: String?, password: String?) {
        loginInteractor.setCredentials(username: username ?? "", password: password ?? "")
    }
    
    func viewDidLoad(view: LoginViewProtocol) {
        view.updateLoginStatus(enabled: false)
    }
}
