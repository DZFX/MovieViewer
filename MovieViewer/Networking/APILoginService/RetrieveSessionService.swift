//
//  RetrieveSessionService.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

protocol RetrieveSessionServiceDelegate: AnyObject {
    func succeeded(with response: CreateSessionResponse)
    func failed(with error: Error)
}


class RetrieveSessionService {
    var serviceURL = APIService.baseURL + "/authentication/session/new"
    weak var delegate: RetrieveSessionServiceDelegate?

    init(delegate: RetrieveSessionServiceDelegate) {
        self.delegate = delegate
    }

    func getCreatedSession(using requestToken: RequestTokenCredentials) {
        let client = RequestTokenHTTPClientDecorator(client: URLSession.shared, bearerToken: APIToken(), requestToken: requestToken)
        client.execute(request: URLRequest(url: URL(string: serviceURL)!,
                                           cachePolicy: .useProtocolCachePolicy)) { [weak self] (result: Result<CreateSessionResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.succeeded(with: response)
            case .failure(let failure):
                self?.delegate?.failed(with: failure)
            }
        }
    }
}
