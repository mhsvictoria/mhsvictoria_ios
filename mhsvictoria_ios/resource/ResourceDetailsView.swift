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
import AppointmentKit

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
        addMapView()
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
        
        let iconStackView = UIStackView()
        iconStackView.distribution = .equalCentering
        iconStackView.axis = .horizontal
        addSubview(iconStackView)
        iconStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(mapViewHeight + 50)),
            iconStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            iconStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            iconStackView.heightAnchor.constraint(equalToConstant: iconViewHeight)
        ])
        
        iconStackView.addArrangedSubview(phoneBtn)
        phoneBtn.addTarget(self, action: #selector(phoneButtonPressed), for: .touchUpInside)
        iconStackView.addArrangedSubview(mailBtn)
        mailBtn.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        iconStackView.addArrangedSubview(helpBtn)
    }
    
    @objc func phoneButtonPressed() {
        if let primaryPhone = data?.contact?.primaryPhone {
            tryToCall(primaryPhone)
        } else {
            if let secondaryPhone = data?.contact?.secondaryPhone {
                tryToCall(secondaryPhone)
            }
        }
    }
    
    func tryToCall(_ number: String) {
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func sendEmail() {
        if let email = data?.contact?.email {
            tryToMail(email)
        }
    }
    
    func tryToMail(_ email: String) {
        guard let emailUrl = URL(string: "mailto:\(email)") else { return }
        UIApplication.shared.open(emailUrl)
        
    }
    
    func addMapView() {

        let mapView = MKMapView()
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
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin)
        ])
    }
}



