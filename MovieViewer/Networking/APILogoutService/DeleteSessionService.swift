//
//  DeleteSessionService.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation


class DeleteSessionService {
    struct RequestBody: Encodable {
        var sessionID: String

        enum CodingKeys: String, CodingKey {
            case sessionID = "session_id"
        }
    }

    struct ResponseBody: Decodable {
        var success: Bool
    }

    var serviceURL = APIService.baseURL + "/authentication/session"

    func deleteSession(_ sessionID: SessionID, completion: @escaping (Result<Void, Error>) -> Void) {
        let client = AuthorizedHTTPClientDecorator(client: URLSession.shared, bearerToken: APIToken())
        var request = URLRequest(url: URL(string: serviceURL)!, cachePolicy: .useProtocolCachePolicy)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(RequestBody(sessionID: sessionID))
        client.execute(request: request) { (result: Result<ResponseBody, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension DeleteSessionService: LogoutServiceProtocol {
    func performLogout(with sessionID: SessionID, completion: @escaping (Result<Void, Error>) -> Void) {
        deleteSession(sessionID, completion: completion)
    }
}
