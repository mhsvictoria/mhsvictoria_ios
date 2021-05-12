//
//  CustomPageControl.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2020-09-20.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class CustomPageControl: UIView {
    
    public var selectedTabNumber = 0 {
        didSet {
            updateUI()
        }
    }
    private var numberOfPages = 3
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorPositionConstraint: NSLayoutConstraint!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        Bundle.main.loadNibNamed("CustomPageControl", owner: self, options: nil)
        addSubview(contentView)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
    
    private func updateUI() {
        if indicatorPositionConstraint != nil {
            indicatorPositionConstraint.isActive =
                false
        }
    
        switch selectedTabNumber {
        case 0:
            indicatorPositionConstraint = indicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        case 1:
            indicatorPositionConstraint = indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        case 2:
            indicatorPositionConstraint = indicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        default:
            break
        }
        self.indicatorPositionConstraint.isActive = true
        UIView.animate(withDuration: 0.2) {
            self.contentView.layoutIfNeeded()
        }
        
    }
}
