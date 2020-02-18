//
//===----------------------------------------------------------------------===//
//
//  TutorialScreen.swift
//
//  Created by Trevor Beasty on 2/4/20.
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

enum TutorialScreenModule: ScreenModule {
    
    struct State: Equatable {
        let title: String
        let body: String
        let buttonTitles: [String]
    }
    
    enum Action: Equatable {
        case didPressButton(index: Int)
    }
    
    enum Output: Equatable {
        case didPressButton(index: Int)
    }
    
    static var defaultInitialState: State { return State(title: "", body: "", buttonTitles: []) }
    
    static func createScreen(with store: TutorialStore) -> Screen {
        return Screen(store, TutorialController(store: store.asViewStore()))
    }
    
}

extension TutorialScreenModule.State {
    
    static let welcome = TutorialScreenModule.State(title: "Welcome!", body: "This tutorial will teach you important things", buttonTitles: ["Skip", "Next"])
    
    static let finish = TutorialScreenModule.State(title: "That was fun!", body: "Now you're ready to go", buttonTitles: ["OK"])
    
}

class TutorialStore: LassoStore<TutorialScreenModule> {
    
    override func handleAction(_ action: TutorialScreenModule.Action) {
        switch action {
            
        case .didPressButton(index: let idx):
            dispatchOutput(.didPressButton(index: idx))
        }
    }
    
}

class TutorialController: UIViewController, LassoView {
    
    let store: TutorialScreenModule.ViewStore
    
    private lazy var titleLabel = UILabel(headline: store.state.title)
    private lazy var bodyLabel = UILabel(body: store.state.body)
    private let buttonStack = UIStackView()
    
    init(store: ViewStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        [titleLabel, bodyLabel, buttonStack].forEach {
            view.addSubview($0)
        }
        
        titleLabel.layout
            .top(to: .safeArea, offset: 50)
            .centerX(to: .safeArea)
        
        bodyLabel.layout
            .left(to: .safeArea, offset: 10)
            .right(to: .safeArea, offset: -10)
            .top(to: titleLabel, edge: .bottom, offset: 50)
        
        buttonStack.layout
            .fillWidth(of: .safeArea, inset: 20, maximum: 280)
            .top(to: bodyLabel, edge: .bottom, offset: 50)

        buttonStack.axis = .vertical
        buttonStack.distribution = .equalSpacing
        buttonStack.alignment = .fill
        buttonStack.spacing = 8
        bodyLabel.textAlignment = .center
        
        for (i, buttonTitle) in store.state.buttonTitles.enumerated() {
            let button = UIButton(standardButtonWithTitle: buttonTitle)
            button.bind(to: store, action: .didPressButton(index: i))
            buttonStack.addArrangedSubview(button)
        }
    }
    
}
