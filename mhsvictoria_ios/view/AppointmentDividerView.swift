//
//  AppointmentFooterView.swift
//  pika
//
//  Created by Ron Allan on 2019-02-22.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

class AppointmentDividerView: UIView {
    
    var lineWidth: CGFloat = 2
    var lineColor: UIColor = primary
    var shadowLineWidth: CGFloat = 1
    var shadowColor: UIColor = UIColor.lightGray
    var drawShadow: Bool = false
    var drawLine: Bool = false
    var drawGradient: Bool = false
    var clear: Bool = false
    var margin: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //drawGradientFillLayer()
        
        if clear {
            //self.backgroundColor = UIColor.white
            self.layer.insertSublayer(CALayer(), at: 0)
            clear = false
            return
        }
        
        if drawGradient {
            self.drawGradientFillLayer(CGRect(x: 0, y: 0, width: rect.width, height: rect.height/3))
            drawGradient = false
        }

        var yOff: CGFloat = rect.height/2
        
        if drawShadow {
            drawLine(rect, color: shadowColor, yOffset: yOff + lineWidth)
        }

        yOff -= lineWidth
        if drawLine {
            drawLine(rect, color: lineColor, yOffset: yOff)
        }
    }
    
    private func drawLine(_ rect: CGRect, color: UIColor, yOffset: CGFloat) {
        NSLog("appointmentDividerView RECT: \(rect)")
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x: margin, y: yOffset))
        path.addCurve(to: CGPoint(x: rect.width - 2 * margin, y: yOffset), controlPoint1: CGPoint(x: rect.width/3, y: 0), controlPoint2: CGPoint(x: 2 * rect.width/3, y: 2 * yOffset))
        color.setStroke()
        path.stroke()

    }
    
    private func drawGradientFillLayer(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect

        let gf1 = primaryVariantLight.withAlphaComponent(0.1).cgColor
        let gf2 = primary.withAlphaComponent(0.1).cgColor
        let gf3 = primaryVariantDark.withAlphaComponent(0.1).cgColor

        gradientLayer.colors = [gf1, gf2, gf3]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
