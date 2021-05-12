//
//  MultiSelectBar.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-04-25.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class MultiSelectBar: UIControl {

    public var field: MultiSelectField?
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    public var selections: [String] = [] {
        didSet {
            updateSelectionsLabel()
        }
    }
    public var isDropdownOpen: Bool = false {
        didSet {
            updateChevronDirection()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionsContainerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var chevronView: UIImageView!
    @IBOutlet weak var selectionsLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        Bundle.main.loadNibNamed("MultiSelectBar", owner: self, options: nil)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.frame = bounds
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        selectionsContainerView.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        selectionsContainerView.layer.borderWidth = 1
        selectionsContainerView.layer.cornerRadius = 10
    }
    
    private func updateSelectionsLabel() {
        var text = ""
        var selections = self.selections
        if selections.count == 0 {
            selectionsLabel.text = ""
        } else {
            text = "\(selections.removeFirst())"
            selections.forEach { text = "\(text), \($0)" }
            selectionsLabel.text = text
        }
    }
    
    private func updateChevronDirection() {
        if isDropdownOpen {
            chevronView.image = UIImage(systemName: "chevron.down")
        } else {
            chevronView.image = UIImage(systemName: "chevron.right")
        }
    }
}
