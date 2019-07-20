//
//  ScoreView.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/19/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    
    public var score: Double? {
        didSet {
            currentScore.text = "\(score ?? 0)"
            animatePulsatingLayer()
        }
    }
    
    private var trackPathLayer : CAShapeLayer!
    private var fillPathLayer  : CAShapeLayer!
    private let fillColor = UIColor(red: 230/255.0, green: 180/255.0, blue: 90/255.0, alpha: 1)
    
    //MARK: downloadText
    private let currentScore : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // enable auto layout
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 230/255.0, green: 180/255.0, blue: 90/255.0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if trackPathLayer == nil && fillPathLayer == nil {
            trackPathLayer = createShapeLayer(fillColor: .clear, strokeColor: .lightGray)
            fillPathLayer = createShapeLayer(fillColor: .clear, strokeColor: fillColor)
            layer.addSublayer(trackPathLayer)
            layer.addSublayer(fillPathLayer)
            
            trackPathLayer.strokeEnd = 1 // to make it visible
            
        } else { // update the position
            let centerBounds = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            trackPathLayer.position = centerBounds
            fillPathLayer.position = centerBounds
        }
    }
    
    private func layoutSetup() {
        backgroundColor = .white
        [currentScore, dateLabel].forEach { addSubview($0) }
        currentScore.anchors(centerX: centerXAnchor, centerY: centerYAnchor)
        dateLabel.anchors(bottom: bottomAnchor, centerX: centerXAnchor)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let dateString = dateFormatter.string(from: Date())
        dateLabel.text = "As of \(dateString)"
    }
    
    private func animatePulsatingLayer() {
        guard let score = score else { return }
        UIView.animate(withDuration: 2.0) { [weak self] in
            self?.fillPathLayer.strokeEnd = CGFloat(score/1000.0)
        }
    }
    
    //MARK: ShapeLayer Setups
    private func createShapeLayer(fillColor : UIColor, strokeColor : UIColor) -> CAShapeLayer {
        let radius: CGFloat = 80.0
        let startAngle: CGFloat = CGFloat.pi/2 // 90 degree at positive side
        let endAngle: CGFloat = 0 // 0 degree
        let centerBounds = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let layer = CAShapeLayer()
        let bezierPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        layer.path = bezierPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineWidth = 30
        layer.strokeEnd = 0 // animate this property
        layer.lineCap = CAShapeLayerLineCap.round // to shape the front while stroking
        layer.position = centerBounds
        return layer
    }
}
