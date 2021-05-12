//
//  SelectableButton.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-02-14.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class SelectableButton: UIButton {
    
    public var optionIsSelected: Bool = false {
        didSet {
            setBackgroundColor()
        }
    }
    
    public var option: String? {
        didSet {
            setTitle(option, for: .normal)
        }
    }
    
    init() {
        super.init(frame: .zero)
        setBackgroundColor()
        setUpButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBackgroundColor()
        setUpButton()
    }
    
    private func setUpButton() {
        titleLabel?.font = UIFont(name: "Karma", size: 15)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
    }
    
    private func setBackgroundColor() {
        if optionIsSelected {
            backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            setTitleColor(.white, for: .normal)
            
        } else {
            setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
            backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        }
    }
}

protocol SelectableButtonDelegate: class {
    func buttonWasPressed(sender: SelectableButton, isSelected: Bool)
}
