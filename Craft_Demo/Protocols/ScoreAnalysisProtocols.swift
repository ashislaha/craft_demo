//
//  ScoreAnalysisProtocols.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/18/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

protocol ScoreAnalysisViewToInteractorProtocol: class {
    var viewController: ScoreAnalysisInteractorToViewProtocol? { get set } // weak hold to view
    var router: ScoreAnalysisInteractorToRouter? {get set} // strong hold to router
    func fetchScoreAnalysis()
}

protocol ScoreAnalysisInteractorToViewProtocol: class {
    var interactor: ScoreAnalysisViewToInteractorProtocol? {get set} // strong hold to interactor
    func fetchedScoreAnalysis(_ model: ScoreAnalysis)
}

protocol ScoreAnalysisInteractorToRouter: class {
    var viewController: ScoreAnalysisInteractorToViewProtocol? { get set } // weak hold to view
    static func create() -> ScoreAnalysisViewController
}


