//
//  LoginContract.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import Foundation

enum LoginError: Error {
    case wrongCredentials
    case other(Error)

    var localizedDescription: String {
        switch self {
        case .wrongCredentials:
            return "Invalid username and/or password. You did not provide a valid login."
        case .other(let error):
            return error.localizedDescription
        }
    }
}

protocol LoginViewProtocol: AnyObject {
    func prefill(with username: String, password: String)
    func updateLoginStatus(enabled: Bool)
    func finished(with error: Error?)
}

protocol LoginPresenterProtocol: AnyObject {
    func viewDidLoad(view: LoginViewProtocol)
}

protocol LoginInteractorInputProtocol: AnyObject {
    var userCredentials: UserCredentials { get }
    func performLogin()
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func loginSucceeded()
    func loginFailed(with error: Error)
}

protocol LoginRouterProtocol: AnyObject {
}

protocol LoginRepoProtocol: AnyObject {
    func performLogin(with username: String, password: String, completionHandler: (Result<Void, Error>) -> Void)
}
