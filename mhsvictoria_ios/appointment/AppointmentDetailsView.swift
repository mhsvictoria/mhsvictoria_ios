//
//  AppointmentDetailsView.swift
//  pika
//
//  Created by Ron Allan on 2019-02-14.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

/*
 Event: EKEvent <0x600002b8afd0>
 {
 EKEvent <0x600002b8afd0>
 {     title =         Daylight Saving Time;
 location =     ;
 calendar =     EKCalendar <0x600000cf7a40> {title = US Holidays; type = Subscription; allowsModify = NO; color = #CC73E1;};
 alarms =         (null);
 URL =             (null);
 lastModified = 2018-05-25 17:05:58 +0000;
 startTimeZone =     (null);
 startTimeZone =     (null)
 };
 location =     ;
 structuredLocation =     (null);
 startDate =     2019-03-10 08:00:00 +0000;
 endDate =         2019-03-11 06:59:59 +0000;
 allDay =         1;
 floating =     1;
 recurrence =     EKRecurrenceRule <0x600003ab6210> RRULE FREQ=YEARLY;INTERVAL=1;COUNT=6;BYMONTH=3;BYDAY=2SU;
 attendees =     (null);
 travelTime =     (null);
 startLocation =     (null);
 };
 */
class AppointmentDetailsView: CardView {
    
    var title: UILabel?
    var dateLabel: UILabel?
    var startEndTimes: UILabel?
    var endDate: UILabel?
    var notesLabel: UILabel?
    var appointment: Appointment? {
        didSet {
            if title == nil {
                createTitle()
            }
            title?.text = appointment?.title
            if dateLabel == nil {
                createDateHeader()
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = ViewUtil.dateFormat
            let dateStr = dateFormatter.string(from: (appointment?.startTime)!)
            dateLabel?.text = dateStr
            if startEndTimes == nil {
                createStartEndTimes()
            }
            startEndTimes?.text = ViewUtil.formatStartEndTime(appointment)
            
            if notesLabel == nil {
                createNotes()
            }
            notesLabel?.text = appointment?.notes
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = toolbarColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = toolbarColor
    }
    
    private func createTitle() {
        title = UILabel()
        title?.font = UIFont(name: fontName, size: fontSizeLarge)
        addSubview(title!)
        title?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title!.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            title!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            title!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            title!.heightAnchor.constraint(equalToConstant: fontSizeMed + marginSmall)
        ])
    }
    
    private func createDateHeader() {
        
        dateLabel = UILabel()
        dateLabel?.font = createFont
        dateLabel?.textAlignment = .left
        addSubview(dateLabel!)
        dateLabel!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            dateLabel!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            dateLabel!.topAnchor.constraint(equalTo: title!.bottomAnchor),
            dateLabel!.heightAnchor.constraint(equalToConstant: fontSizeMed + marginSmall)
        ])
    }
    
    private func createStartEndTimes() {
        
        startEndTimes = UILabel()
        startEndTimes?.font = UIFont(name: fontName, size: fontSizeMed)?.boldItalic
        startEndTimes?.textColor = textDark
        addSubview(startEndTimes!)
        
        startEndTimes!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startEndTimes!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            startEndTimes!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            startEndTimes!.topAnchor.constraint(equalTo: dateLabel!.bottomAnchor),
            startEndTimes!.heightAnchor.constraint(equalToConstant: fontSizeMed + marginSmall)
        ])
        
    }
    
    func createNotes() {
        notesLabel = UILabel()
        addSubview(notesLabel!)
        notesLabel!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesLabel!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            notesLabel!.widthAnchor.constraint(equalToConstant: frame.width - marginMedLrg),
            notesLabel!.topAnchor.constraint(equalTo: startEndTimes!.bottomAnchor, constant: marginSmall)
            
        ])
        notesLabel?.font = cellFont?.italic
        notesLabel?.textColor = UIColor.darkGray
        notesLabel?.numberOfLines = 0
        notesLabel?.lineBreakMode = .byWordWrapping
        notesLabel?.contentMode = .top
    }
}
