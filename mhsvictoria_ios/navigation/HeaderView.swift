//
//  HeaderView.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-16.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var title: String? {
        didSet {
            let label = UILabel(frame: CGRect(x: margin, y: 0, width: frame.width - marginLrg, height: frame.height))
            label.textAlignment = .left
            label.font = sectionHeaderFont
            label.text = title
            addSubview(label)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
        
    }
    
    private func initialization() {
        backgroundColor = toolbarColor
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
