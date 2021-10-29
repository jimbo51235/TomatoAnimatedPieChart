//
//  TomatoPieChart.swift
//  ArcChart
//
//  Created by Tom Bluewater on 12/12/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation
import UIKit

class TomatoMakePieChart {
	static func Doughnut(center: CGPoint, start: CGFloat, end: CGFloat, innerRadius: CGFloat, thickness: CGFloat, inner: CGFloat, outer: CGFloat, pie: CGFloat, color: UIColor, innerAlpha: CGFloat, outerStrokeColor: UIColor, dur: TimeInterval, view: UIView) -> UIView {
        let chartView = UIView.init(frame: CGRect(x: center.x, y: center.y, width: innerRadius + thickness, height: innerRadius + thickness))
        
        let outerPath = UIBezierPath(arcCenter: center, radius: innerRadius + outer, startAngle: start, endAngle: end, clockwise: true)
        let outerLayer = CAShapeLayer()
        outerLayer.path = outerPath.cgPath
        outerLayer.fillColor = UIColor.clear.cgColor
        outerLayer.strokeColor = outerStrokeColor.cgColor
        outerLayer.lineWidth = thickness
        chartView.layer.addSublayer(outerLayer)
        
        let piePath = UIBezierPath(arcCenter: center, radius: innerRadius, startAngle: start, endAngle: end, clockwise: true)
        let pieLayer = CAShapeLayer()
        pieLayer.path = piePath.cgPath
        pieLayer.fillColor = UIColor.clear.cgColor
        pieLayer.strokeColor = color.cgColor
        pieLayer.lineWidth = thickness
        chartView.layer.addSublayer(pieLayer)
        
        let innerPath = UIBezierPath(arcCenter: center, radius: innerRadius - thickness / 2.0 + inner / 2.0, startAngle: start, endAngle: end, clockwise: true)
        let innerLayer = CAShapeLayer()
        innerLayer.path = innerPath.cgPath
        innerLayer.fillColor = UIColor.clear.cgColor
        innerLayer.strokeColor = UIColor.white.withAlphaComponent(innerAlpha).cgColor
        innerLayer.lineWidth = inner
        chartView.layer.addSublayer(innerLayer)
        drawCircleAnimation(key: "strokeEnd", shapeLayer: pieLayer, animationName: "strokeAnimation", fromValue: 0.0, toValue: 1.0, duration: dur, flag: false, removal: false)
        
        return chartView
    }
    
    static func drawCircleAnimation(key: String, shapeLayer: CAShapeLayer, animationName: String, fromValue: CGFloat, toValue: CGFloat, duration: TimeInterval, flag: Bool, removal: Bool) {
        let drawAnimation = CABasicAnimation(keyPath: key)
        drawAnimation.duration = duration
        drawAnimation.repeatCount = 1
        drawAnimation.fromValue = fromValue
        drawAnimation.toValue = toValue
		drawAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut) // timing
        drawAnimation.isRemovedOnCompletion = removal
		drawAnimation.fillMode = CAMediaTimingFillMode.forwards
        drawAnimation.autoreverses = flag
        shapeLayer.add(drawAnimation, forKey: animationName)
    }
}

