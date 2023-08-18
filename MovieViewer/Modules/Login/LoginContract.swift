//
//  LoginContract.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import UIKit

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
    func goToMainGrid()
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
    func showMainGrid(from view: LoginViewProtocol?)
}


typealias SessionID = String
typealias LoginServiceResult = (Result<SessionID, Error>) -> Void

protocol LoginServiceProtocol: AnyObject {
    func performLogin(with username: String, password: String, completionHandler: @escaping LoginServiceResult)
}

protocol LoginRepoProtocol: AnyObject {
    func set(sessionID: String)
}
