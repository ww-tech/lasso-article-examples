//
//===----------------------------------------------------------------------===//
//
//  ContentScreen.swift
//
//  Created by Steven Grosmark on 2/1/20.
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
import WWLayout

enum ContentScreenModule: ScreenModule {
    
    static func createScreen(with store: ContentStore) -> Screen {
        return Screen(store, ContentViewController(store.asViewStore()))
    }
    
}

final class ContentStore: LassoStore<ContentScreenModule> {
    
}

final class ContentViewController: UIViewController {
    
    let store: ContentScreenModule.ViewStore
    
    init(_ store: ContentScreenModule.ViewStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        let headerLabel = UILabel(
            headline: "Content",
            align: .center
        )
        
        let contentLabel = UILabel(
            body: "actual app content would go here",
            align: .center
        )
        
        view.addSubviews(headerLabel, contentLabel)
        
        headerLabel.layout
            .fill(.safeArea, except: .bottom, inset: 30)
        
        contentLabel.layout
            .below(headerLabel, offset: 30)
            .fill(.safeArea, axis: .x, inset: 30)
    }
    
}
