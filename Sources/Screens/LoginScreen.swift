//
//===----------------------------------------------------------------------===//
//
//  LoginScreen.swift
//
//  Created by Steven Grosmark on 11/21/19.
//
//
//  This source file is part of the Lasso open source project
//
//     https://github.com/ww-tech/lasso
//
//  Copyright © 2019-2020 WW International, Inc.
//
//===----------------------------------------------------------------------===//

import UIKit
import Lasso

// MARK: - Module

enum LoginScreenModule: ScreenModule {
    
    enum Action: Equatable {
        case didUpdateUsername(String)
        case didUpdatePassword(String)
        case didTapLogin
    }
    
    enum Output: Equatable {
        case userDidLogin
    }
    
    struct State: Equatable {
        var username: String = ""
        var password: String = ""
        var error: String? = nil
    }
    
    static var defaultInitialState: State {
        return State()
    }
    
    static func createScreen(with store: LoginStore) -> Screen {
        return Screen(store, LoginViewController(store.asViewStore()))
    }
    
}

// MARK: - Store

final class LoginStore: LassoStore<LoginScreenModule> {
    
    override func handleAction(_ action: LoginScreenModule.Action) {
        switch action {
            
        case .didUpdateUsername(let username):
            update { state in
                state.username = username
            }
            
        case .didUpdatePassword(let password):
            update { state in
                state.password = password
            }
            
        case .didTapLogin where state.username.isEmpty || state.password.isEmpty:
            update { state in
                state.error = "Missing credentials"
            }
            
        case .didTapLogin:
            update { state in state.error = nil }
            LoginService.shared.login(state.username, state.password) { [weak self] success in
                guard let self = self else { return }
                self.update { state in
                    state.error = success ? nil : "Invalid login"
                }
                if success {
                    self.dispatchOutput(.userDidLogin)
                }
            }
        }
    }
    
}

// MARK: - View

final class LoginViewController: UIViewController, LassoView {
    
    let store: LoginScreenModule.ViewStore
    
    init(_ store: ViewStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    // MARK: Implementation details
    
    private let headerLabel = UILabel(headline: "Login")
    private let usernameField = UITextField(placeholder: "Username")
    private let passwordField = UITextField(placeholder: "Password")
    private let loginButton = UIButton(standardButtonWithTitle: "Login")
    private let errorLabel = UILabel(body: "", align: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        setUpSubviews()
        setUpConstraints()
        setUpBindings()
    }
    
    private func setUpSubviews() {
        passwordField.isSecureTextEntry = true
        
        view.addSubviews(headerLabel, usernameField, passwordField, loginButton, errorLabel)
    }
    
    private func setUpConstraints() {
        headerLabel.layout
            .top(to: .safeArea, offset: 50)
            .centerX(to: .safeArea)
        
        usernameField.layout
            .below(headerLabel, offset: 50)
            .fillWidth(of: .safeArea, inset: 20, maximum: 280)
        
        passwordField.layout
            .below(usernameField, offset: 30)
            .fillWidth(of: .safeArea, inset: 20, maximum: 280)
        
        loginButton.layout
            .below(passwordField, offset: 50)
            .fillWidth(of: .safeArea, inset: 20, maximum: 280)
        
        errorLabel.layout
            .below(loginButton, offset: 20)
            .fill(.safeArea, axis: .x, inset: 20)
    }
    
    private func setUpBindings() {
        
        // State change inputs:
        store.observeState(\.username) { [weak self] username in
            self?.usernameField.text = username
        }
        store.observeState(\.password) { [weak self] password in
            self?.passwordField.text = password
        }
        store.observeState(\.error) { [weak self] error in
            self?.errorLabel.text = error
        }
        
        // Action outputs:
        usernameField.bindTextDidChange(to: store) { text in
            .didUpdateUsername(text)
        }
        passwordField.bindTextDidChange(to: store) { text in
            .didUpdatePassword(text)
        }
        loginButton.bind(to: store, action: .didTapLogin)
    }
    
}
