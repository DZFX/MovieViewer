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
        let presenter = MainGridPresenter(
            interactor: MainGridInteractor(
                services: [
                    GetPopularMoviesService(),
                    GetTopRatedMoviesService(),
                    GetNowPlayingMoviesService(),
                    GetUpcomingMoviesService()
                ]
            )
        )
        let mainGrid = MainGridViewController(presenter: presenter)
        presenter.view = mainGrid
        view.present(NavigationController(rootViewController: mainGrid), animated: true, completion: nil)
    }
}
