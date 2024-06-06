//
//  CircularProgressView.swift
//  Meditation
//
//  Created by Rishita kumari on 02/06/24.
//

import UIKit

class CircularProgressView1: UIView {

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let circularPath = UIBezierPath(arcCenter: center, radius: bounds.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.lineWidth = 15
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(red: 0/255.0, green: 144/255.0, blue: 81/255.0, alpha: 1.0).cgColor

        progressLayer.lineWidth = 15
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        progressLayer.strokeEnd = progress
    }
}
