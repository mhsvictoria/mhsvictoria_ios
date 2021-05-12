//
//  Form3ViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class Form3ViewController: BaseViewController {
    
    public weak var delegate: Form3ViewControllerDelegate?
    @IBOutlet weak var multiSelectCardContainer: UIStackView!
    @IBOutlet weak var finshButton: UIButton!
    private var locationSelections: [Location] = Location.allCases
    private var costSelections: [Cost] = Cost.allCases
    private let options: [MultiSelectField: [String]] = [
        .location: Location.allCases.map { $0.rawValue },
        .cost: Cost.allCases.map { $0.rawValue }
    ]
    private var multiSelectBars: [MultiSelectField: MultiSelectBar] = [:]
    private var openDropdowns: [MultiSelectField: BaseDropdownView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addCards()
    }
    
    private func configureView() {
        finshButton.layer.cornerRadius = finshButton.frame.height / 2
        finshButton.layer.borderWidth = 1
        finshButton.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.6479023973)
    }
    
    private func addCards() {
        options.forEach { field, options in
            let multiSelectBar = MultiSelectBar()
            multiSelectBar.field = field
            multiSelectBar.title = field.rawValue
            multiSelectBar.isUserInteractionEnabled = true
            multiSelectBar.translatesAutoresizingMaskIntoConstraints = false
            multiSelectBar.selections = ["All"]
            multiSelectBar.addTarget(self, action: #selector(optionWasSelected(_:)), for: .touchUpInside)
            multiSelectCardContainer.addArrangedSubview(multiSelectBar)
            multiSelectBars[field] = multiSelectBar
        }
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        print("finish pressed")
        delegate?.finishWasPressed()
    }
    
    @objc private func optionWasSelected(_ multiSelectBar: MultiSelectBar) {
        guard let field = multiSelectBar.field,
              openDropdowns[field] == nil
        else { return }
        var dropdown: BaseDropdownView
        if field == .cost {
            let costDropdown = DropdownView<Cost>()
            costDropdown.options = Cost.allCases
            costDropdown.currentSelections = costSelections
            dropdown = costDropdown
        } else {
            let locationDropdown = DropdownView<Location>()
            locationDropdown.options = Location.allCases
            locationDropdown.currentSelections = locationSelections
            dropdown = locationDropdown
        }
        dismissAllDropdowns()
        dropdown.delegate = self
        view.addSubview(dropdown)
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        dropdown.topAnchor.constraint(equalTo: multiSelectBar.bottomAnchor, constant: 10).isActive = true
        dropdown.leadingAnchor.constraint(equalTo: multiSelectBar.leadingAnchor).isActive = true
        dropdown.setUpOptions()
        dropdown.open()
        openDropdowns[field] = dropdown
    }
    
    private func dismissAllDropdowns() {
        openDropdowns.forEach { _, dropdown in
            dropdown.close()
        }
        openDropdowns = [:]
    }
}

extension Form3ViewController: DropdownViewDelegate {
    
   
    func dropDownOptionChanged<T>(_ dropdown: BaseDropdownView, selectedOptions: [T]) where T : RawRepresentableAll, T.RawValue == String {
        if let costDropdown = dropdown as? DropdownView<Cost> {
            costSelections = costDropdown.currentSelections ?? []
            multiSelectBars[.cost]?.selections = costSelections.contains { $0 == .all } ? [Cost.all.rawValue] : costSelections.map { $0.rawValue }
        } else if let locationDropdown = dropdown as? DropdownView<Location> {
            locationSelections = locationDropdown.currentSelections ?? []
            multiSelectBars[.location]?.selections = locationSelections.contains { $0 == .all } ? [Location.all.rawValue] : locationSelections.map { $0.rawValue }
        }
    }
    
    func dropDownWasDismissed(_ dropdown: BaseDropdownView) {
        openDropdowns = [:]
    }
}

protocol Form3ViewControllerDelegate: class {
    func finishWasPressed()
}

enum MultiSelectField: String {
    case location = "Location"
    case cost = "Cost"
}
