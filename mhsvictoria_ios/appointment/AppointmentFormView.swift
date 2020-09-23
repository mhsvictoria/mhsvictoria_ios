//
//  AppointmentFormView.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-29.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

class AppointmentFormView: UIView {
    
    let titleField = UITextField()
    let descriptionField = UITextField()
    let dateFromToLabel = UILabel()
    let dateToLabel = UILabel()
    let dateFrom = UIDatePicker()
    let dateTo = UIDatePicker()
    let fromToSelect = UISegmentedControl()
    
    var appointmentId: String?
    
    var appointment: Appointment? {
        didSet {
            if appointment != nil {
                setAppointment(appointment!)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    private func initViews() {
        self.backgroundColor = UIColor.clear
        
        addSubview(titleField)
        titleField.placeholder = "placeholder.enter.title".localized
        titleField.font = UIFont(name: "Arial", size: fontSizeMed)
        titleField.borderStyle = .bezel
        titleField.tag = 0
        
        addSubview(descriptionField)
        descriptionField.placeholder = "placeholder.enter.description".localized
        descriptionField.font = UIFont(name: "Arial", size: fontSizeMed)
        descriptionField.borderStyle = .bezel
        
        dateFromToLabel.font = UIFont(name: "Arial", size: fontSizeSmall)
        dateFromToLabel.text = "Date From"
        dateFromToLabel.textColor = UIColor(0x225c77)
        addSubview(dateFromToLabel)
        
        fromToSelect.insertSegment(withTitle: "time.starting.label".localized, at: 0, animated: true)
        fromToSelect.insertSegment(withTitle: "time.ending.label".localized, at: 1, animated: true)
        fromToSelect.tintColor = UIColor.black
        fromToSelect.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(0x225c77), NSAttributedString.Key.font: UIFont(name: fontName, size: fontSizeMed) as Any],  for: .selected)
    
        fromToSelect.selectedSegmentIndex = 0
    
        fromToSelect.addTarget(self, action: #selector(onValueChanged), for: .valueChanged)
        addSubview(fromToSelect)
        
        addSubview(dateFrom)
        addSubview(dateTo)
        initDatePickers()
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleField.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: marginSmall),
            descriptionField.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionField.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
        
        dateFromToLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateFromToLabel.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: marginSmall),
            dateFromToLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateFromToLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateFromToLabel.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
        
        fromToSelect.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromToSelect.topAnchor.constraint(equalTo: dateFromToLabel.bottomAnchor, constant: marginTiny),
            fromToSelect.leadingAnchor.constraint(equalTo: leadingAnchor),
            fromToSelect.trailingAnchor.constraint(equalTo: trailingAnchor),
            fromToSelect.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
        
        dateFrom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateFrom.topAnchor.constraint(equalTo: fromToSelect.bottomAnchor, constant: marginSmall),
            dateFrom.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateFrom.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateFrom.heightAnchor.constraint(equalToConstant: frame.height/2)
        ])
        dateTo.frame = dateFrom.frame
    }
    
    func setAppointment(_ appointment: Appointment) {
        dateFrom.date = appointment.startTime!
        dateTo.date = appointment.endTime!
        titleField.text = appointment.title
        descriptionField.text = appointment.notes
        appointmentId = appointment.identifier
        
        dateFromToLabel.text = ViewUtil.formatStartEndTime(appointment)
    }
    
    @objc func onValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            dateTo.isHidden = false
            dateFrom.isHidden = true
            dateFromToLabel.text = "Date To"
        } else {
            dateTo.isHidden = true
            dateFrom.isHidden = false
            dateFromToLabel.text = "Date From"
        }
    }
    
    private func initDatePickers() {
        dateFrom.minimumDate = Date().addingTimeInterval(-(60*60*24*3))
        dateFrom.maximumDate = Date().addingTimeInterval(60*60*24*365)
        dateFrom.minuteInterval = 30
        dateFrom.addTarget(self, action: #selector(onFromChanged), for: .valueChanged)
        
        dateTo.minimumDate = dateFrom.minimumDate
        dateTo.maximumDate = dateFrom.maximumDate
        dateTo.minuteInterval = 30
        dateTo.addTarget(self, action: #selector(onToChanged), for: .valueChanged)
        fromToSelect.selectedSegmentIndex = 0
        dateTo.isHidden = true
        dateFrom.isHidden = false
        
    }
    
    @objc func onFromChanged(_ sender: UIDatePicker) {
        dateFromToLabel.text = ViewUtil.formatStartEndTime(sender.date, dateTo.date)
    }
    
    @objc func onToChanged(_ sender: UIDatePicker) {
        dateFromToLabel.text = ViewUtil.formatStartEndTime(dateFrom.date, sender.date)
    }

}
