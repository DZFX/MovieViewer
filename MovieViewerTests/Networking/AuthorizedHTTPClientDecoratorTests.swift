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
        sut.execute(request: startRequest) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.1.value(forHTTPHeaderField: AuthorizedHTTPClientDecorator.authorizationHeader), "Bearer Test Auth Token")
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
    func execute(request: URLRequest, completion: @escaping (Result<(Data?, HTTPURLResponse), Error>) -> ()) {
        completion(.success((request.httpBody, HTTPURLResponse(url: URL(fileURLWithPath: ""),
                                                                                          statusCode: 200,
                                                                                          httpVersion: "",
                                                                                          headerFields: request.allHTTPHeaderFields)!)))
    }
}

struct MockFailHTTPClient: HTTPClient {
    func execute(request: URLRequest, completion: @escaping (Result<(Data?, HTTPURLResponse), Error>) -> ()) {
        completion(.failure(MockError()))
    }
}

struct MockTokenProvider: TokenProvider {
    var token: String { "Test Auth Token" }
}
