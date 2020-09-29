//
//  DayCollectionViewCell.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-17.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

protocol AppointmentSelectionDelegate {
    func onAppointmentSelected(appointment: Appointment?)
}

class DayCollectionViewCell: UICollectionViewCell {
    
    var appointmentSelectionDelegate: AppointmentSelectionDelegate?
    
    var apptLabel: UILabel?
    var dayLabel: UILabel!
    var appointment: Appointment? {
        didSet {
            dayLabel?.font = UIFont(name: "fontName-BoldMT", size: 24)
            layer.borderColor = UIColor.red.cgColor
            layer.borderWidth = 1
            layer.cornerRadius = frame.width/2
        }
    }
   
    var monthDayYear: MonthDayYear? {
        didSet {
            dayLabel.text = "\((monthDayYear?.cardinal)!)"
            dayLabel.font = UIFont(name: fontName, size: 24)
            dayLabel.contentMode = .scaleAspectFill
            layer.borderColor = UIColor.clear.cgColor
            
            let calendar = Calendar.current
            if (monthDayYear?.isCurrentMonth)! {
                dayLabel.textColor = UIColor.black
            } else {
                dayLabel.textColor = UIColor.lightGray
            }
            
            if calendar.isDateInToday((monthDayYear?.date)!) {
                dayLabel.textColor = UIColor.blue
                dayLabel.font = UIFont(name: fontName, size: 24)
                layer.borderColor = UIColor.blue.cgColor
                layer.borderWidth = 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dayLabel = UILabel(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dayLabel = UILabel(frame: CGRect.zero)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            ])
    }
    
    func unselectCell() {
        dayLabel.textColor = UIColor.darkGray
    }
    
    func selectCell() {
        dayLabel.textColor = UIColor.red
        appointmentSelectionDelegate?.onAppointmentSelected(appointment: appointment)
    }
}
