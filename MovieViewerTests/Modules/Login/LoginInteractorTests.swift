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
        sut.performLogin(with: "", password: "")
        XCTAssertNil(sut.loginError)
    }

    func test_loginFailed() {
        let sut = makeSUT(withSuccessfulLogin: false)
        sut.performLogin(with: "", password: "")
        XCTAssertNotNil(sut.loginError)
    }

    func makeSUT(withSuccessfulLogin: Bool) -> LoginInteractor {
        let sut = LoginInteractor(loginService: withSuccessfulLogin ? SuccessMockLoginRepo() : FailingMockLoginRepo())
        return sut
    }
}

struct MockError: Error {}
class FailingMockLoginRepo: LoginRepo {
    func performLogin(with username: String, password: String, completionHandler: (Result<Void, Error>) -> Void) {
        completionHandler(.failure(MockError()))
    }
}

class SuccessMockLoginRepo: LoginRepo {
    func performLogin(with username: String, password: String, completionHandler: (Result<Void, Error>) -> Void) {
        completionHandler(.success(()))
    }
}
