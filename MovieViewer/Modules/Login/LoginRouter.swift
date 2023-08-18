//
//  LoginRouter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 15/08/23.
//

import UIKit

class LoginRouter {
}

extension LoginRouter: LoginRouterProtocol {
    func showMainGrid(from view: LoginViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let mainGrid = UIViewController()
        view.present(mainGrid, animated: true, completion: nil)
    }
}
