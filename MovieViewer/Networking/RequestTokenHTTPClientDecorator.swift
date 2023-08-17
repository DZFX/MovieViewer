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
    let requestToken: RequestTokenCredentials

    init(client: HTTPClient, bearerToken: TokenProvider, requestToken: RequestTokenCredentials) {
        self.requestToken = requestToken
        super.init(client: client, bearerToken: bearerToken)
    }

    override func execute(request: URLRequest, completion: @escaping (Result<(Data?, HTTPURLResponse), Error>) -> ()) {
        var requestTokenizedRequest = request
        requestTokenizedRequest.httpMethod = "POST"
        requestTokenizedRequest.httpBody = try? JSONEncoder().encode(requestToken)
        super.execute(request: requestTokenizedRequest, completion: completion)
    }
}
