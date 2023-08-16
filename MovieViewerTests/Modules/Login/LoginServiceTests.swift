//
//  LoginServiceTests.swift
//  MovieViewerTests
//
//  Created by Isaac Delgado on 16/08/23.
//

import XCTest
@testable import MovieViewer

final class LoginServiceTests: XCTestCase {

    func test_performLogin() {
        let sut = makeSUT()
        XCTAssertNil(sut.requestTokenCredentials)
        let expectation = XCTestExpectation(description: "Waiting for tested log in")
        sut.performLogin(with: "user", password: "pass") { result in
            switch result {
            case .success(let sessionID):
                XCTAssertEqual(sessionID, "Sample Session ID")
                XCTAssertNotNil(sut.requestTokenCredentials)
                XCTAssertEqual(sut.requestTokenCredentials?.requestToken, "Sample Request Token")
                XCTAssertEqual(sut.requestTokenCredentials?.username, "user")
                XCTAssertEqual(sut.requestTokenCredentials?.password, "pass")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_failLoginAtRequestToken() {
        let sut = makeSUT(goodRequest: false)
        XCTAssertNil(sut.requestTokenCredentials)
        let expectation = XCTestExpectation(description: "Waiting for log in to fail at request token")
        sut.performLogin(with: "user", password: "pass") { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssert(error is MockError)
                XCTAssertNotNil(sut.requestTokenCredentials?.username)
                XCTAssertNotNil(sut.requestTokenCredentials?.password)
                XCTAssertEqual(sut.requestTokenCredentials?.requestToken, "")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_failLoginAtCreatingSession() {
        let sut = makeSUT(goodCreate: false)
        XCTAssertNil(sut.requestTokenCredentials)
        let expectation = XCTestExpectation(description: "Waiting for log in to fail at create session")
        sut.performLogin(with: "user", password: "pass") { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssert(error is MockError)
                XCTAssertNotNil(sut.requestTokenCredentials?.username)
                XCTAssertNotNil(sut.requestTokenCredentials?.password)
                XCTAssertEqual(sut.requestTokenCredentials?.requestToken, "Sample Request Token")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_failLoginAtRetrievingSession() {
        let sut = makeSUT(goodRetrieve: false)
        XCTAssertNil(sut.requestTokenCredentials)
        let expectation = XCTestExpectation(description: "Waiting for log in to fail at create session")
        sut.performLogin(with: "user", password: "pass") { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssert(error is MockError)
                XCTAssertNotNil(sut.requestTokenCredentials?.username)
                XCTAssertNotNil(sut.requestTokenCredentials?.password)
                XCTAssertEqual(sut.requestTokenCredentials?.requestToken, "Sample Request Token")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func makeSUT(goodRequest: Bool = true, goodCreate: Bool = true, goodRetrieve: Bool = true) -> LoginService {
        let sut = LoginService()
        sut.requestTokenService = goodRequest ? MockRequestTokenService(delegate: sut) : MockRequestTokenServiceFailure(delegate: sut)
        sut.createSessionService = goodCreate ? MockCreateSessionService(delegate: sut):  MockCreateSessionServiceFailure(delegate: sut)
        sut.retrieveSessionService = goodRetrieve ? MockRetrieveSessionService(delegate: sut) : MockRetrieveSessionServiceFailure(delegate: sut)
        return sut
    }
}

private final class MockRequestTokenService: RequestTokenService {
    override func getRequestToken() {
        delegate?.succeeded(with: RequestTokenResponse(success: true, expiresAt: "", requestToken: "Sample Request Token"))
    }
}

private final class MockCreateSessionService: CreateSessionService {
    override func createSession(using requestToken: RequestTokenCredentials) {
        delegate?.createdSession(with: RequestTokenResponse(success: true, expiresAt: "", requestToken: "Sample Request Token"))
    }
}

private final class MockRetrieveSessionService: RetrieveSessionService {
    override func getCreatedSession(using requestToken: RequestTokenCredentials) {
        delegate?.succeeded(with: CreateSessionResponse(success: true, sessionID: "Sample Session ID"))
    }
}

private final class MockRequestTokenServiceFailure: RequestTokenService {
    override func getRequestToken() {
        delegate?.failed(with: MockError())
    }
}

private final class MockCreateSessionServiceFailure: CreateSessionService {
    override func createSession(using requestToken: RequestTokenCredentials) {
        delegate?.failed(with: MockError())
    }
}

private final class MockRetrieveSessionServiceFailure: RetrieveSessionService {
    override func getCreatedSession(using requestToken: RequestTokenCredentials) {
        delegate?.failed(with: MockError())
    }
}
