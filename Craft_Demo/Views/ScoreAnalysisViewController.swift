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
    
    // landscape mode constraint
    private var scoreViewTopAnchorToSuper: NSLayoutConstraint!   // common for portrait mode as well
    private var scoreViewLeadingAnchorToSuper: NSLayoutConstraint! // common for portrait mode as well
    private var scoreViewBottomAnchorToSuper: NSLayoutConstraint!
    private var scoreViewTrailingAnchorToScoreListView: NSLayoutConstraint!
    
    private var scoreListTopAnchorToSuper: NSLayoutConstraint!
    private var scoreListTrailingAnchorToSuper: NSLayoutConstraint! // common for portrait mode as well
    private var scoreListBottomAnchorToSuper: NSLayoutConstraint! // common for portrait mode as well
    private var scoreListWidthAnchor: NSLayoutConstraint! // 65% of the screen width
    
    // portrait mode
    private var scoreViewBottomAnchorToScoreListView: NSLayoutConstraint!
    private var scoreViewTrailingAnchorToSuperView: NSLayoutConstraint!
    private var scoreViewHeightConstraint: NSLayoutConstraint!  // 35% of the screen height
    
    private var scoreListLeadingAnchorToSuper: NSLayoutConstraint!
    
    // activity indicator
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .blue
        activityIndicator.tintColor = .yellow
        return activityIndicator
    }()
    
    // score view
    private let scoreView: ScoreView = {
        let view = ScoreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // ScoreListView
    private let scoreListView: ScoreListView = {
        let view = ScoreListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func layoutSubViews() {
        [scoreListView, scoreView].forEach{ view.addSubview($0) }
        scoreListView.addSubview(activityIndicator)
        activityIndicator.anchors(centerX: scoreListView.centerXAnchor, centerY: scoreListView.centerYAnchor)
        
        // score view
        
        // landscape set up
        scoreViewTopAnchorToSuper = scoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        scoreViewLeadingAnchorToSuper = scoreView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        scoreViewBottomAnchorToSuper = scoreView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        scoreViewTrailingAnchorToScoreListView = scoreView.trailingAnchor.constraint(equalTo: scoreListView.leadingAnchor)
        
        // portrait set up
        scoreViewBottomAnchorToScoreListView = scoreView.bottomAnchor.constraint(equalTo: scoreListView.topAnchor)
        scoreViewTrailingAnchorToSuperView = scoreView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        scoreViewHeightConstraint = scoreView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35)
        
        // scoreList
        
        // landscape set up
        scoreListTopAnchorToSuper = scoreListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        scoreListTrailingAnchorToSuper = scoreListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        scoreListBottomAnchorToSuper = scoreListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        scoreListWidthAnchor = scoreListView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.65)
        
        // portrait mode
        scoreListLeadingAnchorToSuper = scoreListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        
        let commonConstraints: [NSLayoutConstraint] = [
            scoreViewTopAnchorToSuper, scoreViewLeadingAnchorToSuper, scoreListTrailingAnchorToSuper, scoreListBottomAnchorToSuper
        ]
        NSLayoutConstraint.activate(commonConstraints)
        activeConstraints(isPortrait: UIDevice.current.orientation == .portrait)
    }
    
    
    // MARK:- view controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubViews()
        view.backgroundColor = .white
        title = "Score Analysis"
        activityIndicator.startAnimating()
        interactor?.fetchScoreAnalysis()
        scoreListView.delegate = self
    }
    
    //MARK:- Rotate Device
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        var isPortrait = false
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait, .portraitUpsideDown: isPortrait = true
        default: isPortrait = false
        }
       activeConstraints(isPortrait: isPortrait)
    }
    
    private func activeConstraints(isPortrait: Bool) {
        
        let portraitNecessaryConstraints = [
            scoreViewBottomAnchorToScoreListView, scoreViewTrailingAnchorToSuperView, scoreViewHeightConstraint, scoreListLeadingAnchorToSuper
        ]
        let landScapeNecessaryConstraints = [
            scoreViewBottomAnchorToSuper, scoreViewTrailingAnchorToScoreListView, scoreListTopAnchorToSuper, scoreListWidthAnchor
        ]
        
        if isPortrait {
            // deactive
            landScapeNecessaryConstraints.forEach{ $0?.isActive = false }
            // activate
            portraitNecessaryConstraints.forEach { $0?.isActive = true }
        } else {
            // deactive
            portraitNecessaryConstraints.forEach{ $0?.isActive = false }
            // active
            landScapeNecessaryConstraints.forEach{ $0?.isActive = true }
        }
    }
    
    // MARK:- Fetched score analysis
    func fetchedScoreAnalysis(_ model: ScoreAnalysis?) {
        activityIndicator.stopAnimating()
        scoreListView.model = model
        if let myScore = model?.myScore, let score = Double(myScore) {
            scoreView.score = score
        }
    }
}

extension ScoreAnalysisViewController: ScoreListViewDelegate {
    func refresh() {
        activityIndicator.startAnimating()
        interactor?.fetchScoreAnalysis()
    }
}



