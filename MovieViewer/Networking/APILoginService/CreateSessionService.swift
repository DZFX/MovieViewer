//
//  CreateSessionService.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

protocol CreateSessionServiceDelegate: AnyObject {
    func createdSession(with response: RequestTokenResponse)
    func failed(with error: Error)
}

class CreateSessionService {
    var serviceURL = APIService.baseURL + "/authentication/token/validate_with_login"
    weak var delegate: CreateSessionServiceDelegate?

    init(delegate: CreateSessionServiceDelegate) {
        self.delegate = delegate
    }

    func createSession(using requestToken: RequestTokenCredentials) {
        let client = RequestTokenHTTPClientDecorator(client: URLSession.shared, bearerToken: APIToken(), requestToken: requestToken)
        client.execute(request: URLRequest(url: URL(string: serviceURL)!,
                                           cachePolicy: .useProtocolCachePolicy)) { [weak self] (result: Result<RequestTokenResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.createdSession(with: response)
            case .failure(let failure):
                self?.delegate?.failed(with: failure)
            }
        }
    }
}
