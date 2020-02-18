//
//===----------------------------------------------------------------------===//
//
//  UIKit+Helpers.swift
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
import WWLayout

// MARK: -

extension UILabel {
    
    public convenience init(headline: String?,
                            align: NSTextAlignment? = nil) {
        self.init()
        commonInit(.systemFont(ofSize: 40, weight: .regular), text: headline, align: align)
    }
    
    public convenience init(body: String?,
                            size: CGFloat = 20,
                            weight: UIFont.Weight = .regular,
                            align: NSTextAlignment? = nil) {
        self.init()
        commonInit(.systemFont(ofSize: size, weight: weight), text: body, align: align)
    }
    
    private func commonInit(_ font: UIFont, text: String?, align: NSTextAlignment? = nil) {
        self.font = font
        self.numberOfLines = 0
        self.text = text
        if let align = align {
            self.textAlignment = align
        }
    }
    
}

// MARK: -

extension UITextField {
    
    public convenience init(placeholder: String,
                            text: String = "",
                            autocorrect: UITextAutocorrectionType = .no,
                            autocapitalize: UITextAutocapitalizationType = .none) {
        self.init()
        let border = UIView()
        
        self.autocorrectionType = autocorrect
        self.autocapitalizationType = autocapitalize
        self.placeholder = placeholder
        self.addSubview(border)
        
        self.layout.height(.greaterOrEqual, to: 30)
        border.layout.fill(self, except: .top, inset: Insets(0, -4)).height(2)
        if #available(iOS 13.0, *) {
            border.backgroundColor = .systemGray2
        }
        else {
            border.backgroundColor = .lightGray
        }
    }
    
}

// MARK: -

extension UIButton {
    
    convenience init(standardButtonWithTitle title: String) {
        self.init(type: .custom)
        setTitle(title, for: .normal)
        set(cornerRadius: 5)
        setBackgroundImage(.create(withColor: .appPrimaryTint), for: .normal)
        setBackgroundImage(.create(withColor: UIColor.gray.withAlphaComponent(0.5)), for: .disabled)
        layout.height(44)
    }
    
    @discardableResult
    public func set(title: String, with font: UIFont?) -> UIButton {
        if let font = font {
            let attribs: [NSAttributedString.Key: Any] = [.font: font]
            self.setAttributedTitle(NSAttributedString(string: title, attributes: attribs), for: .normal)
        }
        else {
            self.setTitle(title, for: .normal)
        }
        return self
    }
    
}

// MARK: -

extension UIView {
    
    public func addSubviews(_ views: UIView ...) {
        views.forEach(addSubview)
    }
    
    @discardableResult
    public func set(cornerRadius: CGFloat) -> UIView {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        return self
    }
    
    @discardableResult
    public func set(borderColor: UIColor, thickness: CGFloat) -> UIView {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = thickness
        return self
    }
    
}
