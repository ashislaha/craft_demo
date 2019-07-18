//
//  ScoreAnalysisRouter.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/18/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

class ScoreAnalysisRouter: ScoreAnalysisInteractorToRouter {
    
    weak var viewController: ScoreAnalysisInteractorToViewProtocol? // weak hold to view
    
    static func create() -> ScoreAnalysisViewController {
        let viewController = ScoreAnalysisViewController()
        let router = ScoreAnalysisRouter()
        let interactor = ScoreAnalysisInteractor()
        
        // binding
        viewController.interactor = interactor
        interactor.viewController = viewController
        interactor.router = router
        router.viewController = viewController
        
        return viewController
    }
}
