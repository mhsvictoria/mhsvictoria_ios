//
//  Form2ViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class Form2ViewController: BaseViewController {
    
    let switchToField: [UISwitch: String] = [UISwitch: String]()
    var selectedFields: [String: Bool] = ["Field1": false, "Field2": true, "Field3": false]
    let fieldNames = ["Field1", "Field2", "Field3", "Field4", "Field5", "Field6"]
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
    
    }
    
    func setUpStackViews() { //TODO refactor
        leftStackView.axis = .vertical
        leftStackView.distribution = .equalCentering
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: formHeaderLabel.bottomAnchor, constant: margin),
            leftStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            leftStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            leftStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -margin * 1.5)
        ])
        rightStackView.axis = .vertical
        rightStackView.distribution = .equalCentering
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightStackView.topAnchor.constraint(equalTo: formHeaderLabel.bottomAnchor, constant: margin),
            rightStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            rightStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            rightStackView.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor, constant: margin)
        ])
        
    }
    
    func addSwitches() {
        var switchesStackView = leftStackView
        for (index, field) in fieldNames.enumerated() {
            let fieldLabel = UILabel()
            fieldLabel.text = field
            let uiSwitch = UISwitch()
            let switchContainer = UIStackView(arrangedSubviews: [fieldLabel, uiSwitch])
            switchContainer.axis = .horizontal
            switchContainer.distribution = .fillProportionally
            switchesStackView.addArrangedSubview(switchContainer)
            switchContainer.translatesAutoresizingMaskIntoConstraints = false
            if index == (fieldNames.count / 2) - 1 {
                switchesStackView = rightStackView
            }
        }
    }
    
    @objc func switchPressed(sender: UISwitch) {
        selectedFields[switchToField[sender]!] = sender.isOn
    }
}
