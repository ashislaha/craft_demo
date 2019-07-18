//
//  Entity.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/18/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

struct ScoreAnalysis: Decodable {
    let myScore: String
    let scores: [Score]
    
    private enum CodingKeys : String, CodingKey {
        case myScore = "my_score", scores
    }
}

struct Score: Decodable {
    let lowerRange: String
    let upperRange: String
    let percentage: String
    let backgroundColor: String  // background_RGBA
    
    private enum CodingKeys : String, CodingKey {
        case lowerRange, upperRange, percentage, backgroundColor = "background_RGBA"
    }
}
