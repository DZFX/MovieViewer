//
//  APIToken.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

struct APIToken: TokenProvider {
    var token: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmViODE2NDZmNmY0Yjc3ZmNlMjI2NTI3MzgwNzg5NSIsInN1YiI6IjU1ZDc5MDg5OTI1MTQxNDBiMzAwMDY0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5y8Otfs8QTEgBne1c9c27EDx2fe2V9BvZRAB25KzPOk"
}

enum APIService {
    static let baseURL = "https://api.themoviedb.org/3"
}

struct RequestTokenResponse: Decodable {
    var success: Bool
    var expiresAt: String
    var requestToken: String

    enum CodingKeys: String, CodingKey {
        case success, expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

struct CreateSessionResponse: Decodable {
    var success: Bool
    var sessionID: String

    enum CodingKeys: String, CodingKey {
        case success, sessionID = "session_id"
    }
}
