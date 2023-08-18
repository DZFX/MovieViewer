//
//  LoginService.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import Foundation

struct LoginServiceLostCredentialsError: Error {}

class LoginService {
    var requestTokenCredentials: RequestTokenCredentials?
    lazy var requestTokenService: RequestTokenService = .init(delegate: self)
    lazy var createSessionService: CreateSessionService = .init(delegate: self)
    lazy var retrieveSessionService: RetrieveSessionService = .init(delegate: self)
    private var completionHandler: LoginServiceResult?
}

extension LoginService: LoginServiceProtocol {
    func performLogin(with username: String, password: String, completionHandler: @escaping LoginServiceResult) {
        requestTokenCredentials = RequestTokenCredentials(username: username, password: password, requestToken: "")
        self.completionHandler = completionHandler
        requestTokenService.getRequestToken()
    }
}

extension LoginService: RequestTokenServiceDelegate {
    func succeeded(with response: RequestTokenResponse) {
        requestTokenCredentials?.requestToken = response.requestToken
        guard let tokenCredentials = requestTokenCredentials else {
            failed(with: LoginServiceLostCredentialsError())
            return
        }
        createSessionService.createSession(using: tokenCredentials)
    }
    
    func failed(with error: Error) {
        completionHandler?(.failure(error))
    }
}

extension LoginService: CreateSessionServiceDelegate {
    func createdSession(with response: RequestTokenResponse) {
        guard let requestToken = requestTokenCredentials?.requestToken else {
            failed(with: LoginServiceLostCredentialsError())
            return
        }
        retrieveSessionService.getCreatedSession(using: RequestTokenCredentials(requestToken: requestToken))
    }
}

extension LoginService: RetrieveSessionServiceDelegate {
    func succeeded(with response: CreateSessionResponse) {
        completionHandler?(.success(response.sessionID))
    }
}
