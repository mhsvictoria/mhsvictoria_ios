//
//  DropdownOption.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-04-24.
//  Copyright © 2021 Ron Allan. All rights reserved.
//


import UIKit

class DropdownOption: UIView {

    public weak var delegate: DropdownOptionDelegate?
    public var optionIsSelected: Bool = false {
        didSet {
            checkmarkView.isHidden = !optionIsSelected
        }
    }
    public var optionText: String? {
        didSet {
            optionLabel.text = optionText
        }
    }
    public var showTopLine = true {
        didSet {
            topLine.isHidden = !showTopLine
        }
    }
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var checkmarkView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("DropdownOption", owner: self, options: nil)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optionWasTapped))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func optionWasTapped() {
        delegate?.dropdownOptionWasTapped(self)
    }
}

protocol DropdownOptionDelegate: class {
    func dropdownOptionWasTapped(_ option: DropdownOption)
}
