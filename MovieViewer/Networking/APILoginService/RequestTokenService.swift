//
//  RequestTokenService.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

protocol RequestTokenServiceDelegate: AnyObject {
    func succeeded(with response: RequestTokenResponse)
    func failed(with error: Error)
}

struct RequestTokenServiceInvalidResponseError: Error {}

class RequestTokenService {
    var serviceURL = APIService.baseURL + "/authentication/token/new"
    weak var delegate: RequestTokenServiceDelegate?

    init(delegate: RequestTokenServiceDelegate) {
        self.delegate = delegate
    }

    func getRequestToken() {
        let client = AuthorizedHTTPClientDecorator(client: URLSession.shared, bearerToken: APIToken())
        client.execute(request: URLRequest(url: URL(string: serviceURL)!,
                                           cachePolicy: .useProtocolCachePolicy)) { [weak self] (result: Result<RequestTokenResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.succeeded(with: response)
            case .failure(let failure):
                self?.delegate?.failed(with: failure)
            }
        }
    }
}
