//
//  CardView.swift
//  pika
//
//  Created by Ron Allan on 2019-03-22.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = backgroundWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = backgroundWhite
    }
    
    func sizeTo(parentView: UIView?, widthMargin: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: (parentView?.leadingAnchor)!, constant: widthMargin).isActive = true
        trailingAnchor.constraint(equalTo: (parentView?.trailingAnchor)!, constant: -widthMargin).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
