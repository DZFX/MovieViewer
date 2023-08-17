//
//  AppRouter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import UIKit

protocol AppRouterProtocol {
    func displayFirstScreen(on window: UIWindow?)
}

class AppRouter {
    func showLogin(window: UIWindow?) {
        let interactor = LoginInteractor(userCredentials: UserCredentials(username: "", password: ""), loginService: LoginService())
        let presenter = LoginPresenter(loginStatus: .notLoggedIn, loginInteractor: interactor)
        interactor.interactorOutput = presenter
        let view = LoginViewController(presenter: presenter)
        presenter.view = view

        window?.rootViewController = view
        window?.makeKeyAndVisible()
    }
}

extension AppRouter: AppRouterProtocol {
    func displayFirstScreen(on window: UIWindow?) {
        showLogin(window: window)
    }
}
