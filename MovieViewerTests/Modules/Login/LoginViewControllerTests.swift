//
//  LoginViewControllerTests.swift
//  MovieViewerTests
//
//  Created by Isaac Delgado on 15/08/23.
//

import XCTest
@testable import MovieViewer

final class LoginViewControllerTests: XCTestCase {
    func test_loadView() {
        let sut = makeSUT()
        XCTAssert(sut.usernameText == "")
        XCTAssertNil(sut.passwordTextField.superview)
        XCTAssertNil(sut.errorLabel.superview)
        XCTAssertNil(sut.loginButton.superview)
        sut.loadViewIfNeeded()
        XCTAssert(sut.usernameText == "user")
        XCTAssertNotNil(sut.passwordTextField.superview)
        XCTAssertNotNil(sut.errorLabel.superview)
        XCTAssertNotNil(sut.loginButton.superview)
    }

    func makeSUT() -> LoginViewController {
        let sut = LoginViewController(presenter: MockLoginPresenter())
        return sut
    }
}

private extension LoginViewController {
    var usernameText: String? { usernameTextField.text }
    var passwordText: String? { passwordTextField.text }
    var errorText: String? { errorLabel.text }
    var buttonEnabled: Bool { loginButton.isEnabled }
}

private class MockLoginPresenter: LoginPresenterProtocol {
    func goToMainGrid() {}
    
    var isLoggingIn: Bool { false }
    
    func performLogin() {}
    
    func updateCredentials(username: String?, password: String?) {}
    
    func viewDidLoad(view: MovieViewer.LoginViewProtocol) {
        view.loaded(username: "user")
        view.finishedLogin(with: nil)
        view.updateLoginStatus(enabled: false)
    }
}
