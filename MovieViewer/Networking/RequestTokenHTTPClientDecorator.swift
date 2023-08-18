//
//  RequestTokenHTTPClientDecorator.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

struct RequestTokenCredentials: Codable {
    var username: String?
    var password: String?
    var requestToken: String

    enum CodingKeys: String, CodingKey {
        case username, password, requestToken = "request_token"
    }

    init(username: String? = nil, password: String? = nil, requestToken: String) {
        self.username = username
        self.password = password
        self.requestToken = requestToken
    }
}

class RequestTokenHTTPClientDecorator: AuthorizedHTTPClientDecorator {
    static let contentTypeHeader = "Content-Type"
    let requestToken: RequestTokenCredentials

    init(client: HTTPClient, bearerToken: TokenProvider, requestToken: RequestTokenCredentials) {
        self.requestToken = requestToken
        super.init(client: client, bearerToken: bearerToken)
    }

    override func execute<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        var requestTokenizedRequest = request
        requestTokenizedRequest.addValue("application/json", forHTTPHeaderField: RequestTokenHTTPClientDecorator.contentTypeHeader)
        requestTokenizedRequest.httpMethod = "POST"
        requestTokenizedRequest.httpBody = try? JSONEncoder().encode(requestToken)
        super.execute(request: requestTokenizedRequest, completion: completion)
    }
}
