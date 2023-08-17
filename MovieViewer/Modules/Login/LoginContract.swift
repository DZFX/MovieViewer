//
//  LoginContract.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import UIKit

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
    func loaded(username: String)
    func updateLoginStatus(enabled: Bool)
    func finishedLogin(with error: Error?)
}

protocol LoginPresenterProtocol: AnyObject {
    var isLoggingIn: Bool { get }
    func viewDidLoad(view: LoginViewProtocol)
    func updateCredentials(username: String?, password: String?)
    func performLogin()
}

protocol LoginInteractorInputProtocol: AnyObject {
    var userCredentials: UserCredentials { get }
    func setCredentials(username: String, password: String)
    func performLogin()
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func loginSucceeded()
    func loginFailed(with error: Error)
    func updateLoginStatus(enabled: Bool)
}

protocol LoginRouterProtocol: AnyObject {
    func showLogin(window: UIWindow)
}


typealias SessionID = String
typealias LoginServiceResult = (Result<SessionID, Error>) -> Void

protocol LoginRepoProtocol: AnyObject {
    func performLogin(with username: String, password: String, completionHandler: @escaping LoginServiceResult)
}
