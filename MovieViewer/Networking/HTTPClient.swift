//
//  HTTPClient.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

protocol HTTPClient {
    func execute<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

extension URLSession: HTTPClient {
    struct InvalidHTTPResponseError: Error {}
    func execute<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(InvalidHTTPResponseError()))
                return
            }
            do {
                guard let data = data, httpResponse.statusCode == 200 else {
                    completion(.failure(try APIService.handleFailedResponse(data: data, response: httpResponse)))
                    return
                }
                let decodedModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedModel))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
