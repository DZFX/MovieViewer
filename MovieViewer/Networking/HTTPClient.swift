//
//  HTTPClient.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

protocol HTTPClient {
    func execute(request: URLRequest, completion: @escaping (Result<(Data?, HTTPURLResponse), Error>) -> ())
}

extension URLSession: HTTPClient {
    struct InvalidHTTPResponseError: Error {}
    func execute(request: URLRequest, completion: @escaping (Result<(Data?, HTTPURLResponse), Error>) -> ()) {
        dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(InvalidHTTPResponseError()))
                return
            }
            completion(.success((data, httpResponse)))
        }
        .resume()
    }
}
