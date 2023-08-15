//
//  LoginInteractorTests.swift
//  MovieViewerTests
//
//  Created by Isaac Delgado on 14/08/23.
//

import XCTest
@testable import MovieViewer

final class LoginInteractorTests: XCTestCase {
    func test_loginSucceeded() {
        let sut = makeSUT(withSuccessfulLogin: true)
        sut.performLogin()
        XCTAssertNil(sut.loginError)
    }

    func test_loginFailed() {
        let sut = makeSUT(withSuccessfulLogin: false)
        sut.performLogin()
        XCTAssertNotNil(sut.loginError)
    }

    func makeSUT(withSuccessfulLogin: Bool) -> LoginInteractor {
        let sut = LoginInteractor(userCredentials: UserCredentials(username: "", password: ""),
                                  loginService: withSuccessfulLogin ? SuccessMockLoginRepo() : FailingMockLoginRepo())
        return sut
    }
}

struct MockError: Error {}
class FailingMockLoginRepo: LoginRepoProtocol {
    func performLogin(with username: String, password: String, completionHandler: (Result<Void, Error>) -> Void) {
        completionHandler(.failure(MockError()))
    }
}

class SuccessMockLoginRepo: LoginRepoProtocol {
    func performLogin(with username: String, password: String, completionHandler: (Result<Void, Error>) -> Void) {
        completionHandler(.success(()))
    }
}
