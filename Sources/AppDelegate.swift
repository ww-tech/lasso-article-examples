//
//===----------------------------------------------------------------------===//
//
//  AppDelegate.swift
//
//  Created by Steven Grosmark on 1/6/20.
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appFlow: AppFlow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        window.backgroundColor = .background
        window.tintColor = .appPrimaryTint
        
        appFlow = AppFlow().start(in: window)
        
        window.makeKeyAndVisible()
        
        return true
    }
    
}
