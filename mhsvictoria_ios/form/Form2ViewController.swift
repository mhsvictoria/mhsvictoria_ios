//
//  Form2ViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class Form2ViewController: BaseViewController {

    let options = Identity.allCases
    var selections: [Identity] = []
    weak var delegate: Form2ViewControllerDelegate?
    @IBOutlet weak var buttonContainer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtons()
    }
    
    @objc private func buttonWasPressed(_ button: SelectableButton) {
        button.optionIsSelected = !button.optionIsSelected
        updateSelections(button.tag, button.optionIsSelected)
    }
    
    private func updateSelections(_ optionIndex: Int, _ isSelected: Bool) {
        if optionIndex < options.count {
            if isSelected {
                selections.append(options[optionIndex])
            } else {
                selections.removeAll { $0 == options[optionIndex] }
            }
            delegate?.selectionsDidChange(selections: selections)
        }
    }
    
    private func addButtons() {
        var row: UIStackView?
        options.enumerated().forEach { index, option in
            row = (index + 2) % 2 == 0 ? getRowView() : row
            let button = SelectableButton()
            button.option = option.rawValue
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.addTarget(self, action: #selector(buttonWasPressed(_:)), for: .touchUpInside)
            button.tag = index
            row?.addArrangedSubview(button)
        }
        if options.count % 2 == 1 {
            row?.addArrangedSubview(UIView())
        }
    }
    
    private func getRowView() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 10
        buttonContainer.addArrangedSubview(sv)
        return sv
    }
}

protocol Form2ViewControllerDelegate: class {
    func selectionsDidChange(selections: [Identity])
}
