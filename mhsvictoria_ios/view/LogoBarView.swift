//
//  HeaderView.swift
//  pika
//
//  Created by Ron Allan on 2019-02-10.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

class LogoBarView: UIView {

    var lineWidth: CGFloat = 2
    var lineColor: UIColor = primary
    var shadowLineWidth: CGFloat = 1
    var shadowColor: UIColor = UIColor.lightGray
    var drawShadow: Bool = true
    var drawLine: Bool = true
    var drawGradient: Bool = false
    var clear: Bool = false
    var margin: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    let logoFontSize: CGFloat = fontSizeExtraLarge
    
    var logoLabel: ShadowedLabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addLabel()
    }
    
    func addLabel() {
        let textStr = NSLocalizedString("app.name", comment: "")
        logoLabel = ShadowedLabel(frame: CGRect(x: 0, y: 0, width: 200, height: 46), text: textStr, font: (UIFont(name: NSLocalizedString("app.name", comment: ""), size: logoFontSize)?.with(traits: .traitCondensed))!, textColor: primaryVariantLight)
        addSubview(logoLabel!)
        
        logoLabel?.translatesAutoresizingMaskIntoConstraints = false
    logoLabel?.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 2 * margin).isActive = true
        logoLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2 * margin).isActive = true
        
    }
    
    private func drawGradientFillLayer(_ path: UIBezierPath?) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [primaryVariantLight.cgColor, primary.cgColor, primaryVariantDark.cgColor, primaryVariantDark.cgColor, primary.cgColor]
    
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        gradientLayer.shadowRadius = 4.0
        gradientLayer.shadowOpacity = 1
        
        let mask = CAShapeLayer()
        mask.path = path?.cgPath
        gradientLayer.mask = mask
        
        self.layer.addSublayer(gradientLayer)
    }
    
    private func drawFillLayer(_ path: UIBezierPath?) {
        
        let mainLayer = CAShapeLayer()
        mainLayer.path = path?.cgPath
        mainLayer.fillColor = UIColor.clear.cgColor
        mainLayer.shadowColor = primaryVariantLight.cgColor
        mainLayer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        mainLayer.shadowRadius = 4.0
        mainLayer.shadowOpacity = 1
        self.layer.addSublayer(mainLayer)
    }
    
    private func drawPortrait(_ rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
        path.addLine(to:CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        return path
    }
    
    private func drawLandscape(_ rect: CGRect)  -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to:CGPoint(x: rect.width/3, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        path.fill()
        return path
    }

}
