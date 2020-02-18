//
//===----------------------------------------------------------------------===//
//
//  LoginService.swift
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

import Foundation
import Lasso

// MARK: -

protocol LoginServiceProtocol {
    
    func login(_ username: String,
               _ password: String,
               completion: @escaping (Bool) -> Void)
    
}

// MARK: -

struct LoginService: LoginServiceProtocol {
    
    @Mockable static var shared: LoginServiceProtocol = LoginService()
    
    func login(_ username: String,
               _ password: String,
               completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(true)
        }
    }
    
}
