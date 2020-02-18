//
//===----------------------------------------------------------------------===//
//
//  TutorialFlow.swift
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

import Lasso
import UIKit

enum TutorialFlowModule: FlowModule {
    
    enum Output: Equatable {
        case didFinish
        case didPressSkip
    }
    
    typealias RequiredContext = UINavigationController
    
}

class TutorialFlow: Flow<TutorialFlowModule> {
    
    override func createInitialController() -> UIViewController {
        let welcomeState = TutorialScreenModule.State.welcome
        let introScreen = TutorialScreenModule.createScreen(with: welcomeState)
        
        introScreen.observeOutput({ [weak self] output in
            guard let self = self else { return }
            switch output {
                
            case .didPressButton(index: let index):
                switch index {
                case 0:
                    self.dispatchOutput(.didPressSkip)
                    
                case 1:
                    let finishController = self.assembleFinishController()
                    self.context?.pushViewController(finishController, animated: true)
                    
                default:
                    return
                }
            }
        })
        
        return introScreen.controller
    }
    
    private func assembleFinishController() -> UIViewController {
        let finishState = TutorialScreenModule.State.finish
        let finishScreen = TutorialScreenModule.createScreen(with: finishState)
        
        finishScreen.observeOutput({ [weak self] output in
            guard let self = self else { return }
            switch output {
                
            case .didPressButton(index: let index):
                switch index {
                    
                case 0:
                    self.dispatchOutput(.didFinish)
                    
                default:
                    return
                }
            }
        })
        
        return finishScreen.controller
    }
    
}
