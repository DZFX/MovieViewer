//
//  MainGridInteractor.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

struct MainGridInteractorServiceError: Error {}
class MainGridInteractor: MainGridInteractorProtocol {
    var services: [GetMoviesServiceProtocol]

    init(services: [GetMoviesServiceProtocol]) {
        self.services = services
    }

    func fetchMovies(for sourceIndex: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard sourceIndex < services.count else {
            return completion(.failure(MainGridInteractorServiceError()))
        }
        services[sourceIndex].getMovies { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
