//
//  MainGridPresenter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 17/08/23.
//

import Foundation

class MainGridPresenter {
    let interactor: MainGridInteractorProtocol
    var title: String = "Movies"
    var categoryTitles: [String] = [
        "Popular", "Top Rated", "Now Playing", "Upcoming"
    ]
    var items: [MovieCellModel] = []
    var router: MainGridRouterProtocol
    weak var view: MainGridViewProtocol?

    init(interactor: MainGridInteractorProtocol, router: MainGridRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func performLogOut() {
        interactor.performLogout { [weak self] result in
            switch result {
            case .success:
                guaranteeMainThread {
                    self?.router.returnToLogin(from: self?.view)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func goToProfile() {
        router.displayProfile(from: self.view)
    }
}

extension MainGridPresenter: MainGridPresenterProtocol {
    func displayGridMenu() {
        router.displayGridMenu(in: view, title: "What do you want to do?", actionTitles: ["Profile", "Log out"]) { [weak self] selectedAction in
            switch selectedAction {
            case "Profile":
                self?.goToProfile()
            default:
                self?.performLogOut()
            }
        }
    }
    
    func viewDidLoad() {
        fetch(for: 0)
    }

    func fetch(for categoryIndex: Int) {
        interactor.fetchMovies(for: categoryIndex) { [weak self] result in
            switch result {
            case .success(let movies):
                let viewModels = movies.map(MovieCellModel.init(movie:))
                self?.items = viewModels
                guaranteeMainThread {
                    self?.view?.loadedNewMovies()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
