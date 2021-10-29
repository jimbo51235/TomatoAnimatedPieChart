//
//  ViewController.swift
//  TomatoAnimatedPieChartSample
//
//  Created by Tomato on 2021/10/29.
//

import UIKit
import TomatoPieChartFramework

class ViewController: TomatoPieChartViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		starter = 0.0
		topSpace = 40.0
		radius = 100.0
		pieThickness = 100.0
		innerBorder = 6.0
		outerBorder = 6.0
		innerAlpha = 0.4
		outerBorderColor = UIColor.black.withAlphaComponent(0.1)
		rectWidth = 32.0
		labelHeight = 18.0
		labelFontSize = 16.0
		labelTextColor = UIColor.white
		labelSpace = 6.0
		decimalNum = 2
		titleContainerWidth = 300.0
		titleContainerBackColor = UIColor.black
		titleContainerLayerCornerRadius = 0.0
		titleContainerBottomSpace = 40.0
		animationDuration = 1.5
		
		let model0 = TomatoChartModel(name: "Android", percentage: 230.0, color: UIColor(red: 30/255.0, green: 180/255.0, blue: 52/255.0, alpha: 1), end: 0.0)
		let model1 = TomatoChartModel(name: "iOS", percentage: 120.0, color: UIColor.orange, end: 0.0)
		let model2 = TomatoChartModel(name: "Windows", percentage: 8.0, color: UIColor(red: 0, green: 118/255.0, blue: 194/255.0, alpha: 1), end: 0.0)
		let model3 = TomatoChartModel(name: "Others", percentage: 2.0, color: UIColor.red, end: 0.0)
		chartModels = [model0, model1, model2, model3]
		makeTomatoChart()
	}
}

