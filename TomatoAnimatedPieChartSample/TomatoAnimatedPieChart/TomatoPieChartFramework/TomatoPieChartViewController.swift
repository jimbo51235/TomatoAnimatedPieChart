//
//  TomatoPieChartViewController.swift
//  ArcChart
//
//  Created by Tomato on 2021/10/29.
//  Copyright © 2021 Tom Bluewater. All rights reserved.
//

import UIKit

open class TomatoPieChartViewController: UIViewController {
	// MARK: - Variables
	public var chartModels = [TomatoChartModel]()
	
	public var starter: CGFloat = 0.0
	public var topSpace: CGFloat = 20.0
	public var radius: CGFloat = 100.0
	public var pieThickness: CGFloat = 90.0
	public var innerBorder: CGFloat = 10.0
	public var outerBorder: CGFloat = 4.0
	public var innerAlpha: CGFloat = 0.4
	public var outerBorderColor: UIColor = UIColor.black.withAlphaComponent(0.1)
	public var rectWidth: CGFloat = 20.0
	public var labelHeight: CGFloat = 18.0
	public var labelFontSize: CGFloat = 16.0
	public var labelTextColor: UIColor = UIColor.black
	public var labelSpace: CGFloat = 6.0
	public var decimalNum: Int = 0
	public var titleContainerWidth: CGFloat = 200.0
	public var titleContainerBackColor: UIColor = UIColor.white
	public var titleContainerLayerCornerRadius: CGFloat = 0.0
	public var titleContainerBottomSpace: CGFloat = 20.0
	public var animationDuration: TimeInterval = 1.5
	
	public func makeTomatoChart() {
		if !arePercentagesValid() {
			print("The total of all percentages must be 360.0")
			return
		}
		if !areSizesValid() {
			print("The radius and the outer border size are wrong.")
			return
		}
		if decimalNum < 0 && decimalNum > 3 {
			print("decimalNum must be greater than or equal to 0 and smaller than or equal to 3")
			return
		}
		
		/* checking the top position */
		var topHeight: CGFloat = 0.0
		if let navigationController = navigationController, let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let statusManager = window.windowScene?.statusBarManager {
			let statusFrame = statusManager.statusBarFrame
			let navigationFrame = navigationController.navigationBar.frame
			topHeight = statusFrame.height + navigationFrame.height
		}
		
		let minSize = min(view.frame.size.width / 2.0, view.frame.size.height / 2.0)
		let piePoint = CGPoint(x: minSize / 2.0, y: topHeight + topSpace + outerBorder + (radius + pieThickness / 2.0) / 2.0)
		for i in 0..<chartModels.count {
			let chartModel = chartModels[i]
			if i == 0 {
				let start0 = CGFloat(Double.pi/2.0) * -1.0 + CGFloat(Double.pi/180.0) * starter
				let end0 = start0 + CGFloat(Double.pi/180.0) * chartModel.percentage
				let chartModel0 = TomatoChartModel(name: chartModel.name, percentage: chartModel.percentage, color: chartModel.color, end: end0)
				chartModels.remove(at: 0)
				chartModels.insert(chartModel0, at: 0)
				let pie = chartModel.percentage
				let color = chartModel.color
				let chartView0 = TomatoMakePieChart.Doughnut(center: piePoint, start: start0, end: end0, innerRadius: radius, thickness: pieThickness, inner: innerBorder, outer: outerBorder, pie: pie, color: color, innerAlpha: innerAlpha, outerStrokeColor: outerBorderColor, dur: animationDuration, view: self.view)
				view.addSubview(chartView0)
			} else {
				let previousModel = chartModels[i - 1]
				let start = previousModel.end
				let end = start + CGFloat(Double.pi/180.0) * chartModel.percentage
				let newModel = TomatoChartModel(name: chartModel.name, percentage: chartModel.percentage, color: chartModel.color, end: end)
				chartModels.remove(at: i)
				chartModels.insert(newModel, at: i)
				let pie = chartModel.percentage
				let color = chartModel.color
				let chartView = TomatoMakePieChart.Doughnut(center: piePoint, start: start, end: end, innerRadius: radius, thickness: pieThickness, inner: innerBorder, outer: outerBorder, pie: pie, color: color, innerAlpha: innerAlpha, outerStrokeColor: outerBorderColor, dur: animationDuration, view: self.view)
				view.addSubview(chartView)
			}
		}
		
		makeLabels()
	}
	
	func makeLabels() {
		var yPoint: CGFloat = 4.0
		let rectHeight = getContainerHeight()
		let point = CGPoint(x: (view.bounds.width - titleContainerWidth) / 2.0, y: view.bounds.height - rectHeight - titleContainerBottomSpace)
		let containerRect = CGRect(origin: point, size: CGSize(width: titleContainerWidth, height: rectHeight))
		let containerView = UIView(frame: containerRect)
		containerView.backgroundColor = titleContainerBackColor
		containerView.layer.cornerRadius = titleContainerLayerCornerRadius
		
		for i in 0..<chartModels.count {
			let chartModel = chartModels[i]
			let name = chartModel.name
			
			/* rect */
			let color = chartModel.color
			let rectRect = CGRect(x: 4.0, y: yPoint, width: rectWidth, height: labelHeight)
			let rect = TomatoRectView(frame: rectRect, backColor: color, strokeColor: UIColor.black)
			
			/* label */
			let labelRect = CGRect(x: 4.0 + rectWidth + 4.0, y: yPoint, width: titleContainerWidth - rectWidth - 8.0, height: labelHeight)
			let label = UILabel(frame: labelRect)
			let perStr = makePercentString(num: chartModel.percentage)
			label.text = name + " (" + perStr + "%)"
			label.font = UIFont.systemFont(ofSize: labelFontSize)
			label.textColor = labelTextColor
			
			yPoint += labelHeight + labelSpace
			containerView.addSubview(label)
			containerView.addSubview(rect)
		}
		view.addSubview(containerView)
	}
	
	func makePercentString(num: CGFloat) -> String {
		if decimalNum == 0 {
			return String(format: "%.0f", num / 360.0 * 100.0)
		}
		else if decimalNum == 1 {
			return String(format: "%.1f", num / 360.0 * 100.0)
		}
		else if decimalNum == 2 {
			return String(format: "%.2f", num / 360.0 * 100.0)
		}
		else {
			return String(format: "%.3f", num / 360.0 * 100.0)
		}
	}
	
	func getContainerHeight() -> CGFloat {
		let edges = labelSpace * 2.0
		let rectTotal = labelHeight * CGFloat(chartModels.count)
		let spaceTotal = CGFloat(chartModels.count - 1) * labelSpace
		let total = edges + rectTotal + spaceTotal
		return total
	}
	
	func areSizesValid() -> Bool {
		let halfWidth = UIScreen.main.bounds.width / 2.0
		if halfWidth < (radius + pieThickness + outerBorder) {
			return true
		} else {
			return false
		}
	}
	
	func arePercentagesValid() -> Bool {
		if chartModels.count > 0 {
			var total = Double()
			for i in 0..<chartModels.count {
				let chartModel = chartModels[i]
				total += chartModel.percentage
			}
			return (total == 360.0) ? true : false
		} else {
			return false
		}
	}
}

public struct TomatoChartModel {
	public let name: String
	public let percentage: CGFloat
	public let color: UIColor
	public let end: CGFloat
	
	public init(name: String, percentage: CGFloat,  color: UIColor, end: CGFloat) {
		self.name = name
		self.percentage = percentage
		self.color = color
		self.end = end
	}
}

