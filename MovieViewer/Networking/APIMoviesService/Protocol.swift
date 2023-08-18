//
//  Protocol.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

protocol GetMoviesServiceProtocol {
    var client: HTTPClient { get }
    var urlRequest: URLRequest { get }
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

extension GetMoviesServiceProtocol {
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        client.execute(request: urlRequest, completion: completion)
    }
}
