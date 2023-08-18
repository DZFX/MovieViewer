//
//  RequestTokenHTTPClientDecoratorTests.swift
//  MovieViewerTests
//
//  Created by Isaac Delgado on 16/08/23.
//

import XCTest
@testable import MovieViewer

final class RequestTokenHTTPClientDecoratorTests: XCTestCase {
    
    func test_signRequestWithAuthorization() {
        let sut = makeSUT()
        let startRequest = URLRequest(url: URL(fileURLWithPath: ""))
        XCTAssertNil(startRequest.httpBody)
        let expectation = XCTestExpectation(description: "Test authorized request")
        sut.execute(request: startRequest) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let token = (try JSONDecoder().decode(RequestTokenCredentials.self, from: data)).requestToken
                    XCTAssertEqual(token, "Test Request Token")
                    expectation.fulfill()
                } catch {
                    XCTFail(error.localizedDescription)
                }
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_signRequestWithCredentials() {
        let sut = makeSUT(with: "user", password: "pass")
        let startRequest = URLRequest(url: URL(fileURLWithPath: ""))
        XCTAssertNil(startRequest.httpBody)
        let expectation = XCTestExpectation(description: "Test authorized request")
        sut.execute(request: startRequest) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let tokenCredentials = try JSONDecoder().decode(RequestTokenCredentials.self, from: data)
                    XCTAssertEqual(tokenCredentials.requestToken, "Test Request Token")
                    XCTAssertEqual(tokenCredentials.username, "user")
                    XCTAssertEqual(tokenCredentials.password, "pass")
                    expectation.fulfill()
                } catch {
                    XCTFail(error.localizedDescription)
                }
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func makeSUT(with username: String? = nil, password: String? = nil) -> RequestTokenHTTPClientDecorator {
        let sut = RequestTokenHTTPClientDecorator(client: MockSuccessTokenClient(),
                                                  bearerToken: MockTokenProvider(),
                                                  requestToken: RequestTokenCredentials(username: username,
                                                                                        password: password,
                                                                                        requestToken: "Test Request Token"))
        return sut
    }
}

struct MockSuccessTokenClient: HTTPClient {
    func execute<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(.success(request.httpBody as! T))
    }
}
