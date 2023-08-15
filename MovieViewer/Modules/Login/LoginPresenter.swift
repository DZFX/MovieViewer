//
//  LoginPresenter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 15/08/23.
//

import Foundation

enum LoginStatus {
    case notLoggedIn
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
}

class LoginPresenter {
    var loginStatus: LoginStatus = .notLoggedIn
    let loginInteractor: LoginInteractorInputProtocol

    init(loginStatus: LoginStatus, loginInteractor: LoginInteractorInputProtocol) {
        self.loginStatus = loginStatus
        self.loginInteractor = loginInteractor
    }

    func performLogin() {
        loginInteractor.performLogin()
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func loginSucceeded() {
        loginStatus = .loggedIn
    }
    
    func loginFailed(with error: Error) {
        loginStatus = .loginFailed(error)
    }
}
