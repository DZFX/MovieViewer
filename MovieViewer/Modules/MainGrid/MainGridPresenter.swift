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

class MainGridPresenter {
    let interactor: MainGridInteractorProtocol
    var title: String = "Movies"
    var categoryTitles: [String] = [
        "Popular", "Top Rated", "Now Playing", "Upcoming"
    ]
    var items: [MovieCellModel] = []

    init(interactor: MainGridInteractorProtocol) {
        self.interactor = interactor
    }
}

extension MainGridPresenter: MainGridPresenterProtocol {
    func fetch(for categoryIndex: Int) {
        interactor.fetchMovies(for: categoryIndex) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.items = movies.map(MovieCellModel.init(movie:))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
