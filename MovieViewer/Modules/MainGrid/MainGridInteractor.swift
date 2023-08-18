//
//  MainGridInteractor.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

struct MainGridInteractorServiceError: Error {}
class MainGridInteractor {
    
    var services: [GetMoviesServiceProtocol]
    var logoutService: LogoutServiceProtocol
    var repo: MainGridRepoProtocol

    init(services: [GetMoviesServiceProtocol], logoutService: LogoutServiceProtocol, repo: MainGridRepoProtocol) {
        self.services = services
        self.logoutService = logoutService
        self.repo = repo
    }
}

extension MainGridInteractor: MainGridInteractorProtocol {
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

    func performLogout(completion: @escaping (Result<Void, Error>) -> Void) {
        logoutService.performLogout(with: repo.storedSessionID, completion: completion)
    }
}
