//
//  ScoreRangeTableViewCell.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/19/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ScoreRangeTableViewCell: UITableViewCell {
    
    public var model: Score? {
        didSet {
            updateUI()
        }
    }
    public var currentScore: String?
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal) // set highest content compression resistance
        return label
    }()
    
    private let rangeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: .horizontal) // lower content compression resistance
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    private let rangeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private var arrowShapeLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    
    // Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutView()
    }
    
    private func layoutView() {
        [scoreLabel, rangeView].forEach{ addSubview($0) }
        rangeView.addSubview(rangeValueLabel)
        
        // anchors
        scoreLabel.anchors(leading: leadingAnchor, trailing: rangeView.leadingAnchor, centerY: centerYAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 12))
        rangeView.anchors(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 0, bottom: 6, right: 12))
        
        rangeValueLabel.anchors(leading: rangeView.leadingAnchor, centerY: centerYAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 0))
    }
    
    private func updateUI() {
        guard let model = model else { return }
        
        let backgroundColorRGBA = model.backgroundColor
        let colors = backgroundColorRGBA.components(separatedBy: "-")
        if colors.count == 4 { // R-G-B-Alpha
            let red = Double(colors[0]) ?? 100.0
            let green = Double(colors[1]) ?? 100.0
            let blue = Double(colors[2]) ?? 100.0
            let alpha = Double(colors[3]) ?? 1.0
            rangeView.backgroundColor = UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(alpha))
        }
        
        rangeValueLabel.text = model.lowerRange + "-" + model.upperRange
        scoreLabel.text = model.percentage
        shouldAddArrowViewLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shouldAddArrowViewLayer()
    }
    
    // arrow view layer
    private func shouldAddArrowViewLayer() {
        
        arrowShapeLayer?.removeFromSuperlayer()
        textLayer?.removeFromSuperlayer()
        
        guard let currentScoreStr = currentScore, let currentScore = Double(currentScoreStr), let scoreModel = model,
            let lowerRange = Double(scoreModel.lowerRange), let upperRange = Double(scoreModel.upperRange),
            lowerRange <= currentScore, currentScore <= upperRange
            else { return }
        
        // add a arrow layer to rangeView
        let width: CGFloat = 100
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: rangeView.frame.size.width - 20, y: 10))
        bezierPath.addLine(to: CGPoint(x: rangeView.frame.size.width - width, y: 10))
        bezierPath.addLine(to: CGPoint(x: rangeView.frame.size.width - width - 10, y: rangeView.frame.size.height / 2))
        bezierPath.addLine(to: CGPoint(x: rangeView.frame.size.width - width, y: rangeView.frame.size.height - 10))
        bezierPath.addLine(to: CGPoint(x: rangeView.frame.size.width - 20, y: rangeView.frame.size.height - 10))
        bezierPath.close()
        
        arrowShapeLayer = CAShapeLayer()
        arrowShapeLayer.path = bezierPath.cgPath
        arrowShapeLayer.fillColor = UIColor.white.cgColor
        arrowShapeLayer.strokeColor = UIColor.purple.cgColor
        arrowShapeLayer.lineWidth = 0.5
        rangeView.layer.addSublayer(arrowShapeLayer)
        
        // a text layer to rangeview
        textLayer = CATextLayer()
        textLayer.string = currentScoreStr
        textLayer.fontSize = 15
        textLayer.alignmentMode = .center
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.frame = CGRect(x: rangeView.frame.size.width - width, y: 12, width: width - 20, height: rangeView.frame.size.height / 2)
        rangeView.layer.addSublayer(textLayer)
    }
}
