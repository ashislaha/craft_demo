//
//  ScoreRangeTableViewHeader.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/19/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ScoreRangeTableViewHeader: UITableViewHeaderFooterView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "Where you stand"
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    
    // init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutSetup()
    }
    
    private func layoutSetup() {
        contentView.backgroundColor = .white
        [imageView, title].forEach { addSubview($0) }
        
        imageView.anchors(trailing: title.leadingAnchor, centerY: centerYAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8), size: .init(width: 18, height: 18))
        title.anchors(centerX: centerXAnchor, centerY: centerYAnchor)
    }
}
