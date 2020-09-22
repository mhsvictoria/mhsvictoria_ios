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
    
    var titleField: UITextField!
    var descriptionField: UITextField!
    var dateFromToLabel: UILabel!
    var dateToLabel: UILabel!
    var dateFrom: UIDatePicker!
    var dateTo: UIDatePicker!
    
    var appointmentId: String?
    var fromToSelect: UISegmentedControl?
    
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
         
        titleField = UITextField()
        addSubview(titleField)
        titleField.placeholder = "Enter a title"
        titleField.font = UIFont(name: "Arial", size: fontSizeSmall)
        titleField.borderStyle = .bezel
        titleField.tag = 0
        
        descriptionField = UITextField()
        addSubview(descriptionField)
        descriptionField.placeholder = "Enter a description"
        descriptionField.font = UIFont(name: "Arial", size: fontSizeSmall)
        descriptionField.borderStyle = .bezel
        
        dateFromToLabel = UILabel()
        dateFromToLabel.font = UIFont(name: "Arial", size: fontSizeSmall)
        addSubview(dateFromToLabel)
        
        fromToSelect = UISegmentedControl()
        fromToSelect?.insertSegment(withTitle: "Starting", at: 0, animated: true)
        fromToSelect?.insertSegment(withTitle: "Ending", at: 1, animated: true)
        fromToSelect?.tintColor = primaryVariantLight
        fromToSelect?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: primaryVariantDark, NSAttributedString.Key.font: UIFont(name: fontName, size: fontSizeMed) as Any], for: .selected)
        fromToSelect?.selectedSegmentIndex = 0
        fromToSelect?.addTarget(self, action: #selector(onValueChanged), for: .valueChanged)
        self.addSubview(fromToSelect!)
        
        dateFrom = UIDatePicker()
        addSubview(dateFrom)
        dateTo = UIDatePicker()
        addSubview(dateTo)
        
        initDatePickers()
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var y: CGFloat = 0
        let x: CGFloat = 0
        let margin: CGFloat = 6
        let fieldHeight: CGFloat = 24
        
        y += margin
        titleField.frame = CGRect(x: 0, y: y, width: frame.width - 2 * x, height: fieldHeight)
        NSLog("titleField.frame: \(titleField.frame)")
        y += fieldHeight + margin
        titleField.contentMode = .scaleToFill
        descriptionField.frame = CGRect(x: 0, y: y, width: frame.width - 2 * x, height: fieldHeight)
        y += fieldHeight + margin/2
        
        dateFromToLabel.frame = CGRect(x: 0, y: y, width: frame.width - x, height: fieldHeight)
        
        y += fieldHeight
        fromToSelect?.frame = CGRect(x: 0, y: y, width: frame.width - 2 * x, height: fieldHeight)
        y += fieldHeight
        let height: CGFloat = self.frame.height - y - 2 * margin
        dateFrom.frame = CGRect(x: 0, y: y, width: frame.width - 2 * x, height: height)
        dateTo.frame = CGRect(x: 0, y: y, width: frame.width - 2 * x, height: height)
       
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
            dateTo?.isHidden = false
            dateFrom?.isHidden = true
        } else {
            dateTo?.isHidden = true
            dateFrom?.isHidden = false
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
        fromToSelect?.selectedSegmentIndex = 0
        dateTo?.isHidden = true
        dateFrom?.isHidden = false
        
    }
    
    @objc func onFromChanged(_ sender: UIDatePicker) {
        dateFromToLabel.text = ViewUtil.formatStartEndTime(sender.date, dateTo.date)
    }
    
    @objc func onToChanged(_ sender: UIDatePicker) {
        dateFromToLabel.text = ViewUtil.formatStartEndTime(dateFrom.date, sender.date)
    }

}
