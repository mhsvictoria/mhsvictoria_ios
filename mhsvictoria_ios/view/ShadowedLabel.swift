//
//  HeaderLabel.swift
//  pika
//
//  Created by Ron Allan on 2019-02-10.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

class ShadowedLabel: UILabel {

    var color: UIColor!
    
    convenience init(frame: CGRect, text: String, font: UIFont, textColor: UIColor) {
        self.init(frame: frame)
        
        self.text = text
        self.font = font
        self.textColor = textColor
        
        sizeToFit()
        layer.shadowColor = primaryVariantDark.cgColor
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.masksToBounds = false
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
