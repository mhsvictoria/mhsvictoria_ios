//
//  SearchResultSection.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-03-21.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class SearchResultSection: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var dropdownArrow: UIImageView!
    @IBOutlet weak var resultCardContainer: UIStackView!
    @IBOutlet weak var sectionTitleContainer: UIView!
    
    public var title: String? {
        didSet {
            sectionTitleLabel.text = title
        }
    }
    
    public var results: [Resource] = [] {
        didSet {
            addResults()
        }
    }
    
    private var dropdownOpen = false {
        didSet {
            setChevron()
            if !dropdownOpen {
                resultCardContainer.subviews.forEach { $0.removeFromSuperview() }
            } else {
                addResults()
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SearchResultSection", owner: self, options: nil)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.frame = bounds
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionTapped))
        sectionTitleContainer.addGestureRecognizer(tapGesture)
        dropdownOpen = false
    }
    
    private func setChevron() {
        if dropdownOpen {
            dropdownArrow.image = UIImage(systemName: "chevron.down")
        } else {
            dropdownArrow.image = UIImage(systemName: "chevron.right")
        }
    }
    
    @objc private func sectionTapped() {
        dropdownOpen = !dropdownOpen
    }
    
    private func addResults() {
        
    }
}

