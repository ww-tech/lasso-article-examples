//
//===----------------------------------------------------------------------===//
//
//  LoginScreenTests.swift
//
//  Created by Steven Grosmark on 1/31/20.
//
//
//  This source file is part of the Lasso open source project
//
//     https://github.com/ww-tech/lasso
//
//  Copyright © 2019-2020 WW International, Inc.
//
//===----------------------------------------------------------------------===//

import XCTest
import LassoTestUtilities
@testable import Intro_Article_Examples

class LoginScreenTests: XCTestCase, LassoStoreTestCase {
    
    let testableStore = TestableStore<LoginStore>()
    
    private var mockService: MockLoginService!

    override func setUp() {
        super.setUp()
        
        mockService = MockLoginService()
        mock(LoginService.$shared, with: mockService)
        
        store = LoginStore()
        
        // given - empty state, no error
        XCTAssertStateEquals(LoginScreenModule.State(
            username: "",
            password: "",
            error: nil)
        )
    }
    
    /// Make sure the store responds properly to field value updates
    func test_enterFields() {
        
        // when - enter username
        store.dispatchAction(.didUpdateUsername("Ellie"))
        
        // then - username should match
        XCTAssertStateEquals(updatedMarker { state in
            state.username = "Ellie"
        })
        
        // when - enter password
        store.dispatchAction(.didUpdatePassword("secret"))
        
        // then - password should match
        XCTAssertStateEquals(updatedMarker { state in
            state.password = "secret"
        })
    }
    
    /// Make sure the store enters an error state when the user tries to login
    /// without entering their credentials.
    func test_emptyCredentials() {
        
        // when - tap login with both fields empty
        store.dispatchAction(.didTapLogin)
        
        // then - error!
        XCTAssertStateEquals(updatedMarker { state in
            state.error = "Missing credentials"
        })
    }
    
    /// Make sure an error is cleared when a new login is submitted.
    func test_loginClearsError() {
        
        // given - set up state with valid credentials _and_ previous error
        store.update { state in
            state.username = "Mim"
            state.password = "pip"
            state.error = "Missing credentials"
        }
        syncState()
        
        // when - tap login with both fields empty
        store.dispatchAction(.didTapLogin)
        
        // then - error should have been cleared, while login is processed
        XCTAssertStateEquals(updatedMarker { state in
            state.error = nil
        })
    }
    
    /// Make sure an error state is entered when a login attempt fails.
    func test_failedLogin() {
        
        // when - enter credentials and tap login
        store.dispatchAction(.didUpdateUsername("Ellie"))
        store.dispatchAction(.didUpdatePassword("secret"))
        store.dispatchAction(.didTapLogin)
        
        // then - request initiated
        XCTAssertStateEquals(updatedMarker { state in
            state.username = "Ellie"
            state.password = "secret"
        })
        XCTAssertNotNil(mockService.completion)
        
        // when - login fails
        mockService.respond(with: false)
        
        // then - error state
        XCTAssertStateEquals(updatedMarker { state in
            state.error = "Invalid login"
        })
        XCTAssertOutputs([])
    }
    
    
    /// Make sure the appropriate output is emitted after a successful login.
    func test_successfulLogin() {
        
        // when - enter credentials and tap login
        store.dispatchAction(.didUpdateUsername("Pat"))
        store.dispatchAction(.didUpdatePassword("p4ssw0rd"))
        store.dispatchAction(.didTapLogin)
        
        // then - request initiated
        XCTAssertStateEquals(updatedMarker { state in
            state.username = "Pat"
            state.password = "p4ssw0rd"
        })
        XCTAssertNotNil(mockService.completion)
        
        // when - login succeeds
        mockService.respond(with: true)
        
        // then - user logged in
        XCTAssertStateEquals(updatedMarker { state in
            state.error = nil
        })
        XCTAssertOutputs([.userDidLogin])
    }

}

///
/// A mock login service for emulating service responses
///
private final class MockLoginService: LoginServiceProtocol {
    
    var completion: ((Bool) -> Void)?
    
    func login(_ username: String,
               _ password: String,
               completion: @escaping (Bool) -> Void) {
        XCTAssertNil(self.completion, "Pending login request already exists")
        self.completion = completion
    }
    
    func respond(with success: Bool) {
        completion?(success)
        completion = nil
    }
    
}
