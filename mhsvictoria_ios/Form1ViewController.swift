//
//  Form1ViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class Form1ViewController: BaseViewController {

    var age = 0 {
        didSet {
            setAgeFormLabel()
        }
    }
    let ageFormLabel = UILabel()
    let ageSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAge()
        setSliderValue()
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
        saveAge()
    }
    
    func setAgeFormLabel() {
        ageFormLabel.text = "I am \(age) years old..."
    }
    
    func saveAge() {
        let preferences = UserDefaults.standard
        preferences.set(age, forKey: "age")
    }
    
    func loadAge() {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "age") != nil {
            age = preferences.integer(forKey: "age")
        } else {
            age = 25
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
