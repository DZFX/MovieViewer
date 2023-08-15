//
//  LoginInteractor.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import Foundation

class LoginInteractor {
    let loginService: LoginRepo
    var loginError: Error?

    init(loginService: LoginRepo) {
        self.loginService = loginService
    }
}

extension LoginInteractor: LoginInteractorInput {
    func performLogin(with username: String, password: String) {
        loginService.performLogin(with: username, password: password) { [weak self] result in
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
