//
//  LoginContract.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
}

protocol LoginPresenterProtocol: AnyObject {
    func viewDidLoad(view: LoginViewProtocol)
}

protocol LoginInteractorInputProtocol: AnyObject {
    func performLogin(with username: String, password: String)
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
