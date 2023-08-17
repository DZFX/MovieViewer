//
//  LoginInteractor.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import Foundation

class LoginInteractor {
    var userCredentials: UserCredentials
    let loginService: LoginRepoProtocol
    weak var interactorOutput: LoginInteractorOutputProtocol?
    var loginError: Error?

    init(userCredentials: UserCredentials, loginService: LoginRepoProtocol) {
        self.userCredentials = userCredentials
        self.loginService = loginService
    }

    func validateCredentials() {
        let value = !userCredentials.username.isEmpty && !userCredentials.password.isEmpty
        interactorOutput?.updateLoginStatus(enabled: value)
    }
}

extension LoginInteractor: LoginInteractorInputProtocol {
    func setCredentials(username: String, password: String) {
        userCredentials.username = username
        userCredentials.password = password
        validateCredentials()
    }
    
    func performLogin() {
        loginService.performLogin(with: userCredentials.username, password: userCredentials.password) { [weak self] result in
            switch result {
            case .success:
                self?.interactorOutput?.loginSucceeded()
            case .failure(let error):
                self?.loginError = error
                self?.interactorOutput?.loginFailed(with: error)
            }
        }
    }
}
