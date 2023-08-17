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
                                           cachePolicy: .useProtocolCachePolicy)) { [weak self] result in
            switch result {
            case .success(let success):
                do {
                    guard let data = success.0, success.1.statusCode == 200 else {
                        self?.delegate?.failed(with: try APIService.handleFailedResponse(data: success.0, response: success.1))
                        return
                    }
                    let createSessionResponse = try JSONDecoder().decode(CreateSessionResponse.self, from: data)
                    self?.delegate?.succeeded(with: createSessionResponse)
                } catch {
                    self?.delegate?.failed(with: error)
                }
            case .failure(let failure):
                self?.delegate?.failed(with: failure)
            }
        }
    }
}
