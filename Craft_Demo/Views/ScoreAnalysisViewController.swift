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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .blue
        activityIndicator.tintColor = .yellow
        return activityIndicator
    }()
    
    // ScoreListView
    private let scoreListView: ScoreListView = {
        let view = ScoreListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private func layoutSubViews() {
        [scoreListView].forEach{ view.addSubview($0) }
        scoreListView.addSubview(activityIndicator)
        activityIndicator.anchors(centerX: scoreListView.centerXAnchor, centerY: scoreListView.centerYAnchor)
        
        scoreListView.anchors(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        scoreListView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6).isActive = true
        
    }
    
    
    // MARK:- view controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubViews()
        view.backgroundColor = .lightGray
        title = "Score Analysis"
        activityIndicator.startAnimating()
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
        activityIndicator.stopAnimating()
        scoreListView.model = model
    }
}



