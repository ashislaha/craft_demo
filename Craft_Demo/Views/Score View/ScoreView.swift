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
            animatePulsatingLayer()
        }
    }
    
    private var trackPathLayer : CAShapeLayer!
    private var fillPathLayer  : CAShapeLayer!
    
    //MARK: downloadText
    private let currentScore : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // enable auto layout
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .yellow
        label.textAlignment = .center
        label.text = "820"
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
    
    private func layoutSetup() {
        addSubview(currentScore)
        currentScore.anchors(centerX: centerXAnchor, centerY: centerYAnchor)
        
        trackPathLayer = createShapeLayer(fillColor: .red, strokeColor: .green)
        fillPathLayer = createShapeLayer(fillColor: .blue, strokeColor: .orange)
        layer.addSublayer(trackPathLayer)
        layer.addSublayer(fillPathLayer)
        
        trackPathLayer.strokeEnd = 1 // to make it visible
    }
    
    private func animatePulsatingLayer() {
        guard let score = score else { return }
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.fillPathLayer.strokeEnd = CGFloat(score/1000.0)
        }
    }
    
    //MARK: ShapeLayer Setups
    private func createShapeLayer(fillColor : UIColor, strokeColor : UIColor) -> CAShapeLayer {
        let radius: CGFloat = 100.0
        let startAngle: CGFloat = CGFloat.pi/2 // 90 degree at positive side
        let endAngle: CGFloat = 0 // 0 degree
        
        let layer = CAShapeLayer()
        let bezierPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        layer.path = bezierPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineWidth = 20
        layer.strokeEnd = 0 // animate this property
        layer.lineCap = CAShapeLayerLineCap.round // to shape the front while stroking
        layer.position = center
        return layer
    }
}
