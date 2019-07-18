//
//  ScoreAnalysisViewController.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/17/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ScoreAnalysisViewController: UIViewController, ScoreAnalysisInteractorToViewProtocol {
    
    var interactor: ScoreAnalysisViewToInteractorProtocol?  // strong hold to interactor
    
    // MARK:- view controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "Score Analysis"
        interactor?.fetchScoreAnalysis()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let orientation =  UIApplication.shared.statusBarOrientation
        
        switch orientation {
        case .portrait, .portraitUpsideDown:
            print("portroit")
            
        default:
            print("landscape")
            
        }
    }
    
    // MARK:- Fetched score analysis
    func fetchedScoreAnalysis(_ model: ScoreAnalysis?) {
        print(model)
    }
}



