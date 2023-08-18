//
//  LoginRouter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 15/08/23.
//

import UIKit

class LoginRouter {
    weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
}

extension LoginRouter: LoginRouterProtocol {
    func showMainGrid() {
        let mainGrid = UIViewController()
        window?.rootViewController?.present(mainGrid, animated: true, completion: nil)
    }
}
