//
//  HeaderView.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-16.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

public class HeaderView: UIView {
    
    var button: UIButton?
    var title: String? {
        didSet {
            let label = UILabel(frame: CGRect(x: marginLrg + imageSize, y: 0, width: frame.width - marginLrg, height: frame.height))
            label.textAlignment = .left
            label.font = sectionHeaderFont
            label.text = title
            label.textColor = primaryDark
            addSubview(label)
            
            // chevron.right
        }
    }
    
    var buttonName: String? {
        didSet {
            button = UIButton(frame: CGRect(x: margin, y: (frame.height - imageSize)/2, width: imageSize, height: imageSize))
            button?.setImage(UIImage(systemName: buttonName!), for: .normal)
            button?.tintColor = toolbarColor
            addSubview(button!)
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
    
    var headerLabel: UILabel?
    
    convenience init(frame: CGRect, header: String?, font: UIFont?, color: UIColor?) {
        self.init(frame: frame)
        
        headerLabel = UILabel(frame: CGRect(x: marginLrg + imageSize, y: (frame.height - font!.pointSize)/2, width: frame.width/2, height: font!.pointSize))
        headerLabel?.text = header
        headerLabel?.textColor = color
        headerLabel?.font = font
        addSubview(headerLabel!)

    }

    private func initialization() {
        backgroundColor = primaryDark
        headerLabel?.frame.size.width = frame.width - margin
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
