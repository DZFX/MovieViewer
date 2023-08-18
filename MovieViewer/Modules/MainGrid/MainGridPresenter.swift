//
//  MainGridPresenter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 17/08/23.
//

import Foundation

protocol MainGridInteractorProtocol {
    func fetchMovies(for sourceIndex: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
}

protocol MainGridViewProtocol: AnyObject {
    func loadedNewMovies()
}

class MainGridPresenter {
    let interactor: MainGridInteractorProtocol
    var title: String = "Movies"
    var categoryTitles: [String] = [
        "Popular", "Top Rated", "Now Playing", "Upcoming"
    ]
    var items: [MovieCellModel] = []
    weak var view: MainGridViewProtocol?

    init(interactor: MainGridInteractorProtocol) {
        self.interactor = interactor
    }
}

extension MainGridPresenter: MainGridPresenterProtocol {
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
