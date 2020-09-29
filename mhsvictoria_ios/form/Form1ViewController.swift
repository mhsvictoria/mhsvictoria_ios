//
//  Form1ViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit


class Form1ViewController: BaseViewController {

    var age: Int {
        get {
            if UserDefaults.standard.object(forKey: ageKey) != nil {
                return UserDefaults.standard.integer(forKey: ageKey)
            }
            return defaultAge
        } set {
            UserDefaults.standard.set(newValue, forKey: ageKey)
            let format = NSLocalizedString("age.label", comment: "")
            ageFormLabel.text = String.localizedStringWithFormat(format, age)
        }
    }
    let ageFormLabel = UILabel()
    let ageSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageSlider.value = Float(age) / sliderDivisor
        let format = NSLocalizedString("age.label", comment: "")
        ageFormLabel.text = String.localizedStringWithFormat(format, age)
        view.addSubview(ageFormLabel)
        view.addSubview(ageSlider)
        ageSlider.translatesAutoresizingMaskIntoConstraints = false
        ageFormLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            ageSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            ageSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            ageFormLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            ageFormLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            ageFormLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin)
        ])
        
        ageSlider.addTarget(self, action: #selector(self.sliderValueChanged), for: .valueChanged)
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        age = Int(sender.value * sliderDivisor)
    }
    
    
}
