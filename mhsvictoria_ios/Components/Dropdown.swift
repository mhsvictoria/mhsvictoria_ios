//
//  Dropdown.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-05-08.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit


import UIKit

class DropdownView<T: RawRepresentableAll>: BaseDropdownView where T.RawValue == String {

    public var options: [T] = []
    public var currentSelections: [T]?
    private let optionContainer = UIStackView()
    private var heightConstraint: NSLayoutConstraint?
    private let cornerRadius: CGFloat = 10
    private var allOption: DropdownOption?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        optionContainer.distribution = .fillEqually
        optionContainer.axis = .vertical
        addAndConstrainSubview(optionContainer)
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        widthAnchor.constraint(equalToConstant: 220).isActive = true
        heightConstraint?.isActive = true
        backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    /// Add selection options to the dropdown.
    override func setUpOptions() {
        let isAllSelected = currentSelections?.contains { $0 == .all } ?? false
        options.enumerated().forEach { index, option in
            let dropdownOption = DropdownOption(frame: .zero)
            dropdownOption.tag = index
            dropdownOption.optionText = option.rawValue
            dropdownOption.optionIsSelected =  isAllSelected || currentSelections?.contains { $0 == option } == true
            dropdownOption.showTopLine = false
            dropdownOption.delegate = self
            optionContainer.addArrangedSubview(dropdownOption)
            if option == T.all {
                allOption = dropdownOption
            }
        }
        addDismissButton()
    }
    
    private func addDismissButton() {
        let dismissButton = UIButton()
        dismissButton.titleLabel?.font = UIFont(name: "Karma-Regular", size: 18)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        optionContainer.addArrangedSubview(dismissButton)
    }
    
    @objc private func dismissPressed() {
        close()
    }
    
    /// Opens the dropdown.
    override func open() {
        self.superview?.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.heightConstraint?.isActive = false
            self.heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(self.options.count + 1) * 45)
            self.heightConstraint?.isActive = true
            self.superview?.layoutIfNeeded()
        })
    }
    
    /// Closes the dropdown.
    override func close() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.heightConstraint?.isActive = false
            self.heightAnchor.constraint(equalToConstant: 0).isActive = true
            self.superview?.layoutIfNeeded()
        }, completion: { _ in
            self.delegate?.dropDownWasDismissed(self)
            self.removeFromSuperview()
        })
    }
}

extension DropdownView: DropdownOptionDelegate {
    func dropdownOptionWasTapped(_ option: DropdownOption) {
        let selectionGenerator = UISelectionFeedbackGenerator()
        selectionGenerator.prepare()
        selectionGenerator.selectionChanged()
        let wasSelected = option.optionIsSelected
        if option.tag < options.count {
            if options[option.tag] == .all {
                optionContainer.subviews
                    .compactMap { $0 as? DropdownOption }
                    .forEach { $0.optionIsSelected = !wasSelected }
                currentSelections = !wasSelected ? options : []
            } else {
                if !wasSelected {
                    currentSelections?.append(options[option.tag])
                } else {
                    currentSelections?.removeAll { $0 == options[option.tag] || $0 == .all }
                }
                allOption?.optionIsSelected = false
                option.optionIsSelected = !wasSelected
            }
            delegate?.dropDownOptionChanged(self, selectedOptions: currentSelections ?? [])
        }
    }
}

protocol DropdownViewDelegate: class {
    func dropDownOptionChanged<T: RawRepresentableAll>(_ dropdown: BaseDropdownView, selectedOptions: [T]) where T.RawValue == String
    func dropDownWasDismissed(_ dropdown: BaseDropdownView)
}

class BaseDropdownView: UIView {
    public weak var delegate: DropdownViewDelegate?
    public func close() {}
    public func open() {}
    public func setUpOptions() {}
}

protocol RawRepresentableAll: RawRepresentable {
    static var all: Self { get }
}
