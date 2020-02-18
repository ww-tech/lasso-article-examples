//
//===----------------------------------------------------------------------===//
//
//  AppFlow.swift
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

///
/// AppFlow is a simple class used to direct the high-level flow of the app.
///
///     Login -> Tutorial -> Content
///
final class AppFlow {
    
    @discardableResult
    func start(in window: UIWindow) -> AppFlow {
        
        LoginScreenModule
            .createScreen()
            .observeOutput { [weak self] output in
                switch output {

                case .userDidLogin:
                    self?.showTutorial()
                }
            }
            .place(with: root(of: window))
        
        return self
    }
    
    private func showTutorial() {
        TutorialFlow()
            .observeOutput { [weak self] output in
                switch output {
                case .didFinish, .didPressSkip:
                    self?.showAppContent()
                }
            }
            .start(with: rootOfApplicationWindow(using: .push)?.withNavigationEmbedding())
    }
    
    private func showAppContent() {
        ContentScreenModule
            .createScreen()
            .place(with: rootOfApplicationWindow(using: .push))
    }
    
}
