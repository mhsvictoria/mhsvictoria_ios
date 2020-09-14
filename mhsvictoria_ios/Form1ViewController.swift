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
            if UserDefaults.standard.object(forKey: "age") != nil {
                return UserDefaults.standard.integer(forKey: "age")
            }
            return 25
        } set {
            UserDefaults.standard.set(newValue, forKey: "age")
            setLabelText()
        }
    }
    let ageFormLabel = UILabel()
    let ageSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSliderValue()
        setLabelText()
        view.addSubview(ageFormLabel)
        view.addSubview(ageSlider)
        ageSlider.translatesAutoresizingMaskIntoConstraints = false
        ageFormLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ageSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ageSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            ageFormLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            ageFormLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ageFormLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        ageSlider.addTarget(self, action: #selector(self.sliderValueChanged), for: .valueChanged)
    }
    
    func setSliderValue() {
        ageSlider.value = Float(age) / 100
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        age = Int(sender.value * 100)
    }
    
    func setLabelText() {
        let format = NSLocalizedString("age.label", comment: "")
        ageFormLabel.text = String.localizedStringWithFormat(format, age)
        
    }
}
