//
//  ActionbarView.swift
//  pika
//
//  Created by Ron Allan on 2019-03-04.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

enum SelectedAction {
    case create, clear, delete, update
}

protocol ActionbarDelegate {
    func onAction(_ action: SelectedAction, message: String?)
}

class ActionbarView: UIView {

    var cancelText = "Clear"
    var createText = "Save"
    var deleteText = "Delete"
    var updateText = "Update"
    
    var clearButton: UIButton!
    var createButton: UIButton!
    var deleteButton: UIButton!
    
    var actionbarDelegate: ActionbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButtons()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // space all 3 buttons evenly
        let width = frame.width/3
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: width).isActive = true

        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: createButton.trailingAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func initButtons() {
        backgroundColor = UIColor.clear
        clearButton = createButton(cancelText, imageName: "clear_icon")
        clearButton.addTarget(self, action: #selector(onClear), for: .touchUpInside)
        addSubview(clearButton)
        
        createButton = createButton(createText, imageName: "save_icon")
        createButton.addTarget(self, action: #selector(onCreate), for: .touchUpInside)
        addSubview(createButton)
        
        deleteButton = createButton(deleteText, imageName: "delete_icon")
        deleteButton.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        addSubview(deleteButton)
    }
    
    func createButton(_ title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(primary, for: .normal)
        button.setTitleColor(secondary, for: .selected)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        button.titleLabel?.font = UIFont(name: fontName, size: fontSizeSmall)
        button.withImageDisabled(imageNamed: imageName)
        button.withImageNormal(imageNamed: imageName)
     
        return button
    }
    
    @objc func onClear(_ sender: UIButton) {
        actionbarDelegate?.onAction(.clear, message: sender.titleLabel?.text)
    }
    
    @objc func onCreate(_ sender: UIButton) {
        if sender.titleLabel?.text == createText {
            actionbarDelegate?.onAction(.create, message: sender.titleLabel?.text)
        } else {
            actionbarDelegate?.onAction(.update, message: sender.titleLabel?.text)
        }
    }
    
    @objc func onDelete(_ sender: UIButton) {
        actionbarDelegate?.onAction(.delete, message: sender.titleLabel?.text)
    }
}
