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
    var loginError: Error?

    init(userCredentials: UserCredentials, loginService: LoginRepoProtocol) {
        self.userCredentials = userCredentials
        self.loginService = loginService
    }
}

extension LoginInteractor: LoginInteractorInputProtocol {
    func performLogin() {
        loginService.performLogin(with: userCredentials.username, password: userCredentials.password) { [weak self] result in
            switch result {
            case .success:
                print("Logged In")
            case .failure(let error):
                print("Failed login with error: \(error)")
                self?.loginError = error
            }
        }
    }
}
