//
//  LoginPresenterTests.swift
//  MovieViewerTests
//
//  Created by Isaac Delgado on 15/08/23.
//

import XCTest
@testable import MovieViewer

final class LoginPresenterTests: XCTestCase {

    func test_successfulLogin() {
        let sut = makeSUT()
        XCTAssertFalse(sut.loginStatus.isLoggedIn)
        XCTAssertFalse(sut.loginStatus.hadError)
        sut.loginSucceeded()
        XCTAssert(sut.loginStatus.isLoggedIn)
        XCTAssertFalse(sut.loginStatus.hadError)
    }

    func test_failedLogin() {
        let sut = makeSUT()
        XCTAssertFalse(sut.loginStatus.isLoggedIn)
        XCTAssertFalse(sut.loginStatus.hadError)
        let mockError = MockError()
        sut.loginFailed(with: mockError)
        XCTAssert(sut.loginStatus.hadError)
        XCTAssertFalse(sut.loginStatus.isLoggedIn)
    }

    func makeSUT() -> LoginPresenter {
        let sut = LoginPresenter(loginStatus: .notLoggedIn,
                                 loginInteractor: MockLoginInteractorInputProtocolImplementation(),
                                 router: LoginRouter())
        return sut
    }
}

class MockLoginInteractorInputProtocolImplementation: LoginInteractorInputProtocol {
    func setCredentials(username: String, password: String) {}
    
    var userCredentials: MovieViewer.UserCredentials = UserCredentials(username: "", password: "")
    
    func performLogin() {
        
    }
}
