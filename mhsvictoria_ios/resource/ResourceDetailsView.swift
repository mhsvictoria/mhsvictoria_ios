//
//  ResourceDetailsView.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-10-19.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class ResourceDetailsView: UIView {

    var data: Resource? {
        didSet {
            setUpView()
        }
    }

    let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        backgroundColor = lightSlateGrey
        if let safeData = data {
            titleLabel.textColor = .black
            titleLabel.text = safeData.name
            titleLabel.textAlignment = .center
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.heightAnchor.constraint(equalToConstant: 30),
                titleLabel.widthAnchor.constraint(equalToConstant: 200)
            ])
            
        }
        addIcons()
    }
    
    func addIcons() {

        let symbolConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let mail = UIImage(systemName: "envelope.fill", withConfiguration: symbolConfig)
        let mailBtn = UIButton()
        mailBtn.setImage(mail, for: .normal)
        
        
        let phone = UIImage(systemName: "phone.fill", withConfiguration: symbolConfig)
        let phoneBtn = UIButton()
        phoneBtn.setImage(phone, for: .normal)

        let help = UIImage(systemName: "questionmark.diamond.fill", withConfiguration: symbolConfig)
        let helpBtn = UIButton()
        helpBtn.setImage(help, for: .normal)
        
        let iconStackView = UIStackView()
        iconStackView.distribution = .equalCentering
        iconStackView.axis = .horizontal
        addSubview(iconStackView)
        iconStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            iconStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            iconStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            iconStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        iconStackView.addArrangedSubview(phoneBtn)
        iconStackView.addArrangedSubview(mailBtn)
        iconStackView.addArrangedSubview(helpBtn)
    }
}
