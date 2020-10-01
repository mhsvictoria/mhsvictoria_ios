//
//  Form2ViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class Form2ViewController: BaseViewController {
    
    var defaultSelectedFields: [String: Bool] = ["Field1": false, "Field2": false, "Field3": false, "Field4": false, "Field5": false, "Field6": false]
    let fieldKey = "fieldKey"
    var selectedFields: [String: Bool] {
        get {
            if UserDefaults.standard.object(forKey: fieldKey) != nil {
                return UserDefaults.standard.dictionary(forKey: fieldKey) as! [String: Bool]
            }
            return defaultSelectedFields
        } set {
            UserDefaults.standard.set(newValue, forKey: fieldKey)
        }
    }
 
    
    var switchToField: [UISwitch: String] = [UISwitch: String]()
    let leftStackView = UIStackView()
    let rightStackView = UIStackView()
    let formHeaderLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formHeaderLabel.text = "Select all that apply: "
        view.addSubview(formHeaderLabel)
        formHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            formHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            formHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin)
        ])
        view.addSubview(leftStackView)
        view.addSubview(rightStackView)
        setUpStackViews()
        addSwitches()
        updateUI()
        
    }
    
    func updateUI() {
        for (uiSwitch, field) in switchToField {
            if selectedFields[field] != nil {
                uiSwitch.setOn(selectedFields[field]!, animated: false)
            }
        }
    }
    
    func setUpStackViews() {
        for sv in [leftStackView, rightStackView] {
            sv.axis = .vertical
            sv.distribution = .equalCentering
            sv.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                sv.topAnchor.constraint(equalTo: formHeaderLabel.bottomAnchor, constant: margin),
                sv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            ])
        }
        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            leftStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -margin * 1.5)
        ])
        NSLayoutConstraint.activate([
            rightStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            rightStackView.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor, constant: margin)
        ])
    }
    
    func addSwitches() {
        var switchesStackView = leftStackView
        let keys = selectedFields.keys
        for (index, field) in keys.enumerated() {
            let fieldLabel = UILabel()
            fieldLabel.text = field
            let uiSwitch = UISwitch()
            let switchContainer = UIStackView(arrangedSubviews: [fieldLabel, uiSwitch])
            switchContainer.axis = .horizontal
            switchContainer.distribution = .fillProportionally
            switchesStackView.addArrangedSubview(switchContainer)
            switchContainer.translatesAutoresizingMaskIntoConstraints = false
            if index == (keys.count / 2) - 1 {
                switchesStackView = rightStackView
            }
            switchToField[uiSwitch] = field
            uiSwitch.addTarget(self, action: #selector(switchPressed(sender:)), for: .valueChanged)
        }
    }
    
    @objc func switchPressed(sender: UISwitch) {
        selectedFields[switchToField[sender]!] = sender.isOn
    }
}
