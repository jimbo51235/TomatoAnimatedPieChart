//
//  TomatoRectView.swift
//  ArcChart
//
//  Created by Tomato on 2021/10/29.
//  Copyright © 2021 Tom Bluewater. All rights reserved.
//

import UIKit

class TomatoRectView: UIView {
	let backColor: UIColor
	let strokeColor: UIColor
	
	init(frame: CGRect, backColor: UIColor, strokeColor: UIColor) {
		self.backColor = backColor
		self.strokeColor = strokeColor
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		let size = self.bounds.size
		
		let p1 = self.bounds.origin // top-left
		let p2 = CGPoint(x: p1.x + size.width, y: p1.y) // top-right
		let p3 = CGPoint(x: p1.x + size.width, y: size.height) // bottom-right
		let p4 = CGPoint(x: p1.x, y: size.height) // bottom-left
		
		// create the path
		let path = UIBezierPath()
		path.move(to: p1)
		path.addLine(to: p2)
		path.addLine(to: p3)
		path.addLine(to: p4)
		path.close()
		
		// fill the path
		backColor.set()
		path.fill()
		
		// stroke
		strokeColor.set()
		path.stroke()
	}
}
