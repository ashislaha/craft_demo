//
//  ScoreAnalysisInteractor.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/18/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

struct Constants {
    static let url = "https://demo4725727.mockable.io/getScore"
}

class ScoreAnalysisInteractor: ScoreAnalysisViewToInteractorProtocol {
    
    weak var viewController: ScoreAnalysisInteractorToViewProtocol? // weak hold of view
    
    var router: ScoreAnalysisInteractorToRouter? // strong hold of router
    
    func fetchScoreAnalysis() {
        NetworkLayer.getData(urlString: Constants.url, successBlock: { [weak self] (data) in
            
            guard let data = data as? Data else {
                self?.viewController?.fetchedScoreAnalysis(nil)
                return
            }
            do {
                let scoreAnalysis = try JSONDecoder().decode(ScoreAnalysis.self, from: data)
                DispatchQueue.main.async {
                    self?.viewController?.fetchedScoreAnalysis(scoreAnalysis)
                }
            } catch let error {
                print("Error in decoding the json:", error)
                self?.viewController?.fetchedScoreAnalysis(nil)
            }
        }) { [weak self] (error) in
            self?.viewController?.fetchedScoreAnalysis(nil)
        }
    }
}
