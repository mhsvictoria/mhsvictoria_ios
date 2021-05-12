//
//  ViewUtil.swift
//  pika
//
//  Created by Ron Allan on 2019-02-15.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit


extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
}

extension UIView {
    func createShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
    
    func withGradient(color1: UIColor, color2: UIColor, color3: UIColor, alpha: CGFloat, cornerRadius: CGFloat) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        let gf1 = color1.withAlphaComponent(alpha).cgColor
        let gf2 = color2.withAlphaComponent(alpha).cgColor
        let gf3 = color3.withAlphaComponent(alpha).cgColor
        gradientLayer.colors = [gf1, gf2, gf3]
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func bezierShadowLayer(cornerRadius: CGFloat?) {
        let shadowLayer = CAShapeLayer()
        
        var cr: CGFloat = 0
        if cornerRadius != nil {
            cr = cornerRadius!
        }
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cr).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 0.5
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    public func addAndConstrainSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension UIButton {
    func withImageNormal(imageNamed: String) {
        let image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        imageView?.tintColor = primary
    }
    
    func withImageDisabled(imageNamed: String) {
        let image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .disabled)
        imageView?.tintColor = UIColor.lightGray
    }
}
