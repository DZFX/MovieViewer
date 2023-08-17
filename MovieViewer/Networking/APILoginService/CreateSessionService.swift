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
                                           cachePolicy: .useProtocolCachePolicy)) { [weak self] result in
            switch result {
            case .success(let success):
                do {
                    guard let data = success.0, success.1.statusCode == 200 else {
                        self?.delegate?.failed(with: try APIService.handleFailedResponse(data: success.0, response: success.1))
                        return
                    }
                    let requestTokenResponse = try JSONDecoder().decode(RequestTokenResponse.self, from: data)
                    self?.delegate?.createdSession(with: requestTokenResponse)
                } catch {
                    self?.delegate?.failed(with: error)
                }
            case .failure(let failure):
                self?.delegate?.failed(with: failure)
            }
        }
    }
}
