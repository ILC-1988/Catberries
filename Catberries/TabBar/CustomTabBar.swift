//
//  CustomTabBar.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

final class CustomTabBar: UITabBar {
    private var tabBarWidth: CGFloat { self.bounds.width }
    private var tabBarHeight: CGFloat { self.bounds.height }
    private var centerWidth: CGFloat { self.bounds.width / 2 }
    private var shapeLayer: CALayer?

    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
        path.close()
        return path.cgPath
    }

    private func drawTabBar() {

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = #colorLiteral(red: 0.6830508832, green: 0.6700330661, blue: 0.507898741, alpha: 1)
        shapeLayer.fillColor = UIColor.systemGray6.cgColor
        shapeLayer.lineWidth = 2.0

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        self.tintColor = #colorLiteral(red: 0.5761333348, green: 0.2789922424, blue: 0.3314428648, alpha: 1)
        self.shapeLayer = shapeLayer
    }

    override func draw(_ rect: CGRect) {
        drawTabBar()
    }
}
