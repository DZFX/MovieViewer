//
//  AuthorizedHTTPClientDecorator.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

protocol TokenProvider {
    var token: String { get }
}

class AuthorizedHTTPClientDecorator: HTTPClient {
    static let authorizationHeader = "Authorization"
    static let acceptHeader = "Accept"
    let client: HTTPClient
    let bearerToken: TokenProvider

    init(client: HTTPClient, bearerToken: TokenProvider) {
        self.client = client
        self.bearerToken = bearerToken
    }

    func execute<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        var authorizedRequest = request
        authorizedRequest.allHTTPHeaderFields?.removeValue(forKey: AuthorizedHTTPClientDecorator.authorizationHeader)
        authorizedRequest.addValue("Bearer \(bearerToken.token)", forHTTPHeaderField: AuthorizedHTTPClientDecorator.authorizationHeader)
        authorizedRequest.addValue("application/json", forHTTPHeaderField: AuthorizedHTTPClientDecorator.acceptHeader)
        client.execute(request: authorizedRequest, completion: completion)
    }
}
