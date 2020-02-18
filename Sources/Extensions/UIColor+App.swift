//
//===----------------------------------------------------------------------===//
//
//  UIColor+App.swift
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

import UIKit

extension UIColor {
    
    static var background: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        }
        else {
            return UIColor.white
        }
    }
    
    static var appPrimaryTint: UIColor {
        return UIColor(red: 0.5, green: 0.3, blue: 1.0, alpha: 1.0)
    }
    
    static var text: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemFill
        }
        else {
            return UIColor.black
        }
    }
    
    #if canImport(SwiftUI)
    #else
    static let systemBackground: UIColor = .white
    static let systemFill: UIColor = .black
    static let systemGray2: UIColor = .lightGray
    #endif
}
