//
//  AuthorizedHTTPClientDecoratorTests.swift
//  MovieViewerTests
//
//  Created by Isaac Delgado on 16/08/23.
//

import XCTest
@testable import MovieViewer

final class AuthorizedHTTPClientDecoratorTests: XCTestCase {

    func test_signRequestWithAuthorization() {
        let sut = makeSUT()
        let startRequest = URLRequest(url: URL(fileURLWithPath: ""))
        XCTAssertNotEqual(startRequest.value(forHTTPHeaderField: AuthorizedHTTPClientDecorator.authorizationHeader), "Bearer Test Auth Token")
        let expectation = XCTestExpectation(description: "Test authorized request")
        sut.execute(request: startRequest) { (result: Result<String, Error>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success, "Bearer Test Auth Token")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func makeSUT() -> AuthorizedHTTPClientDecorator {
        let sut = AuthorizedHTTPClientDecorator(client: MockSuccessHTTPClient(), bearerToken: MockTokenProvider())
        return sut
    }
}

struct MockSuccessHTTPClient: HTTPClient {
    func execute<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(.success(request.value(forHTTPHeaderField: AuthorizedHTTPClientDecorator.authorizationHeader) as! T))
    }
}

struct MockFailHTTPClient: HTTPClient {
    func execute<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(.failure(MockError()))
    }
}

struct MockTokenProvider: TokenProvider {
    var token: String { "Test Auth Token" }
}
