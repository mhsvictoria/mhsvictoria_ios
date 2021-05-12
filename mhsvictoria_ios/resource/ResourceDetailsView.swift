//
//  ResourceDetailsView.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-10-19.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class ResourceDetailsView: UIView {

    var data: Resource? {
        didSet {
            setUpView()
        }
    }

    let titleLabel = UILabel()
    let bulletContainer = UIStackView()
    let resourceDescription = UILabel()
    let iconContainer = UIStackView()
    let mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        backgroundColor = lightSlateGrey
        addTitle()
        addDescription()
        addBullets()
        addIcons()
        addMapView()
    }
    
    func addTitle() {

        if let safeData = data {
            titleLabel.textColor = .black
            titleLabel.text = safeData.name
            titleLabel.textAlignment = .left
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.numberOfLines = 0
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: margin),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
            ])
        }
    }
    
    func addDescription() {

        resourceDescription.text = "Here is a placeholder description of the service, where we would summarize what the service is."
        addSubview(resourceDescription)
        resourceDescription.numberOfLines = 0
        resourceDescription.lineBreakMode = .byWordWrapping
        resourceDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resourceDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            resourceDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            resourceDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin)
        ])
    }
    
    func addBullets() {

        bulletContainer.translatesAutoresizingMaskIntoConstraints = false
        bulletContainer.distribution = .equalCentering
        addSubview(bulletContainer)
        NSLayoutConstraint.activate([
            bulletContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            bulletContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            bulletContainer.topAnchor.constraint(equalTo: resourceDescription.bottomAnchor, constant: margin),
            bulletContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
        bulletContainer.axis = .vertical

        let fakeBulletPts = ["Some fake", "Bullet points", "About the", "resource"]
        for bullet in fakeBulletPts {
            
            let bulletLabel = UILabel()
            bulletLabel.text = bullet

            let checkIcon = UIImageView(image: UIImage(systemName: "checkmark.square"))
            checkIcon.tintColor = slateGrey
            checkIcon.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
            checkIcon.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)

            let container = UIStackView()
            container.spacing = 5
            container.alignment = .leading
            container.distribution = .fillProportionally
            container.axis = .horizontal
            container.addArrangedSubview(checkIcon)
            container.addArrangedSubview(bulletLabel)
            bulletContainer.addArrangedSubview(container)
        }
    }
    
    func addIcons() {

        let symbolConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let mail = UIImage(systemName: "envelope.fill", withConfiguration: symbolConfig)
        let mailBtn = UIButton()
        mailBtn.setImage(mail, for: .normal)
        mailBtn.tintColor = slateGrey

        let phone = UIImage(systemName: "phone.fill", withConfiguration: symbolConfig)
        let phoneBtn = UIButton()
        phoneBtn.setImage(phone, for: .normal)
        phoneBtn.tintColor = slateGrey

        let help = UIImage(systemName: "questionmark.diamond.fill", withConfiguration: symbolConfig)
        let helpBtn = UIButton()
        helpBtn.setImage(help, for: .normal)
        helpBtn.tintColor = slateGrey

        iconContainer.distribution = .equalCentering
        iconContainer.axis = .horizontal
        addSubview(iconContainer)
        iconContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: bulletContainer.bottomAnchor, constant: margin),
            iconContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            iconContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            iconContainer.heightAnchor.constraint(equalToConstant: iconViewHeight)
        ])

        iconContainer.addArrangedSubview(phoneBtn)
        phoneBtn.addTarget(self, action: #selector(phoneButtonPressed), for: .touchUpInside)
        iconContainer.addArrangedSubview(mailBtn)
        mailBtn.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        iconContainer.addArrangedSubview(helpBtn)
    }

    @objc func phoneButtonPressed() {
        
    }

    func tryToCall(_ number: String) {
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number)
    }

    @objc func sendEmail() {
    }

    func tryToMail(_ email: String) {
        guard let emailUrl = URL(string: "mailto:\(email)") else { return }
        UIApplication.shared.open(emailUrl)
        
    }

    func addMapView() {

        addSubview(mapView)
        mapView.layer.cornerRadius = 5
        mapView.layer.borderColor = slateGrey.cgColor
        mapView.layer.borderWidth = 2
        mapView.translatesAutoresizingMaskIntoConstraints = false

        let location = CLLocation(latitude: 48.432228, longitude: -123.357513)
        mapView.centerToLocation(location)
        let pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = location.coordinate
        pinAnnotation.title = data?.name ?? "Location"
        mapView.addAnnotation(pinAnnotation)

        NSLayoutConstraint.activate([
            mapView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mapView.widthAnchor.constraint(equalToConstant: mapViewWidth),
            mapView.heightAnchor.constraint(equalToConstant: mapViewHeight),
            mapView.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: margin),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin)
        ])
    }
}



