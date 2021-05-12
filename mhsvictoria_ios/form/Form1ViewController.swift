//
//  Form1ViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit
import TextFieldEffects

class Form1ViewController: BaseViewController {

    @IBOutlet weak var ageField: HoshiTextField!
    weak var delegate: Form1ViewControllerDelegate?
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        addTextField()
        addDoneButton()
        addTapDismiss()
    }
    
    private func addTextField() {
        ageField.placeholderFontScale = 1
        ageField.keyboardType = .numberPad
        ageField.roundCorners(radius: 10)
        ageField.delegate = self
        ageField.addTarget(self, action: #selector(ageFieldChanged(_:)), for: .editingChanged)
    }
    
    /// Adds done button to numberpad toolbar.
    private func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .black
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(dismissKeyboard))
        done.tintColor = .white
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        ageField?.inputAccessoryView = doneToolbar
    }
       
    private func addTapDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        ageField?.resignFirstResponder()
    }
    
    @objc func ageFieldChanged(_ field: HoshiTextField) {
        if let ageString = field.text, let age = Int(ageString) {
            delegate?.ageSelected(age: age)
        }
    }
}

extension Form1ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

protocol Form1ViewControllerDelegate: class {
    func ageSelected(age: Int)
}

