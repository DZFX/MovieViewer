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
                                           cachePolicy: .useProtocolCachePolicy)) { [weak self] result in
            switch result {
            case .success(let success):
                do {
                    guard let data = success.0, success.1.statusCode == 200 else {
                        self?.delegate?.failed(with: try APIService.handleFailedResponse(data: success.0, response: success.1))
                        return
                    }
                    let requestTokenResponse = try JSONDecoder().decode(RequestTokenResponse.self, from: data)
                    self?.delegate?.succeeded(with: requestTokenResponse)
                } catch {
                    self?.delegate?.failed(with: error)
                }
            case .failure(let failure):
                self?.delegate?.failed(with: failure)
            }
        }
    }
}
