//
//  LoginContract.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 14/08/23.
//

import Foundation

protocol LoginView: AnyObject {
}

protocol LoginPresenter: AnyObject {
    func viewDidLoad(view: LoginView)
}

protocol LoginInteractorInput: AnyObject {
    func performLogin(with username: String, password: String)
}

protocol LoginInteractorOutput: AnyObject {
    func loginSucceeded()
    func loginFailed(with error: Error)
}

protocol LoginRouter: AnyObject {
}

protocol LoginRepo: AnyObject {
    func performLogin(with username: String, password: String, completionHandler: (Result<Void, Error>) -> Void)
}
