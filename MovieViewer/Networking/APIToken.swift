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

    static func handleFailedResponse(data: Data?, response: HTTPURLResponse) throws -> APIServiceError {
        guard let data = data else {
            return APIServiceError(success: false, statusCode: response.statusCode, statusMessage: "Response status: \(response.statusCode)")
        }
        let error = try JSONDecoder().decode(APIServiceError.self, from: data)
        return error
    }
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

struct APIServiceError: Error, Decodable {
    var success: Bool
    var statusCode: Int
    var statusMessage: String

    enum CodingKeys: String, CodingKey {
        case success, statusCode = "status_code"
        case statusMessage = "status_message"
    }

    var localizedDescription: String { statusMessage }
}

func guaranteeMainThread(work: @escaping () -> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async(execute: work)
    }
}
