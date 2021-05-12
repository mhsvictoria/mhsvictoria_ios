//
//  MultiSelectAlertViewController.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-02-20.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class MultiSelectAlertViewController: UIViewController {
    /*
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var optionsContainer: UIStackView!
    var hasAllOption = false
    weak var delegate: MultiSelectViewControllerDelegate?
    var options: [String] = []
    var selections: [String: Bool] = [:]
    var allOptionView: MultiSelectOption?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addOptions()
    }
    
    private func setUpView() {
        alertView.layer.cornerRadius = 5
        addBlurEffect()
    }
    
    private func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
    }
    
    private func addOptions() {
        var allOptions = ["All"]
        allOptions.append(contentsOf: options)
        for option in allOptions {
            let optionView = MultiSelectOption(option)
            optionView.isSelected = selections[option] ?? false
            optionView.translatesAutoresizingMaskIntoConstraints = false
            optionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            optionView.delegate = self
            optionsContainer.addArrangedSubview(optionView)
        }
    }
    
    private func setAllSelected(isSelected: Bool) {
        options.forEach { option in
            selections[option] = isSelected
        }
        optionsContainer.arrangedSubviews.forEach { view in
            if let optionView = view as? MultiSelectOption {
                optionView.isSelected = isSelected
            }
        }
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MultiSelectAlertViewController: MultiOptionDelegate {
    func optionValueChanged(option: String, value: Bool) {
        
        if option == "All" {
            setAllSelected(isSelected: value)
        } else {
            allOptionView?.isSelected = false
            selections[option] = value
            delegate?.selectionsDidChange(newSelections: selections, index: 0)
        }
    }
    */
}

protocol MultiSelectViewControllerDelegate: class {
    func selectionsDidChange(newSelections: [String: Bool], index: Int)
}
