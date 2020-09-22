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
    
    let margin: CGFloat = 10
    var y: CGFloat = 10
    var title: UILabel?
    var dateLabel: HeaderView?
    var startEndTimes: UILabel?
    var endDate: UILabel?
    var notesLabel: UILabel?
    var appointment: Appointment? {
        didSet {
            // Title
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
            dateLabel?.headerLabel?.text = dateStr
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func createTitle() {
        title = UILabel()
        title?.font = UIFont(name: fontName, size: fontSizeLarge)
        
        title?.sizeToFit()
        title?.frame.origin = CGPoint(x: margin, y: y/2)
        title?.frame.size = CGSize(width: self.frame.width, height: fontSizeLarge + 2)
        addSubview(title!)
    }
    
    private func createDateHeader() {
        
        y += fontSizeMed + margin
        
        let font = UIFont(name: fontName, size: fontSizeSmall)
        let color = textLight
        
        dateLabel = HeaderView(frame: CGRect(x: margin, y: y, width: self.frame.width/2, height: fontSizeSmall + 2), header: "", font: font!, color: color)
        dateLabel?.headerLabel?.textAlignment = .left
        addSubview(dateLabel!)
    }
    
    private func createStartEndTimes() {
        
        y += fontSizeSmall + margin/2
        
        startEndTimes = UILabel()
        startEndTimes?.font = UIFont(name: fontName, size: fontSizeSmall)?.boldItalic
        startEndTimes?.frame.origin = CGPoint(x: margin, y: y)
        startEndTimes?.frame.size = CGSize(width: self.frame.width, height: fontSizeSmall + 2)
        startEndTimes?.textColor = textDark
        addSubview(startEndTimes!)
        
    }
    
    func createNotes() {
        y += fontSizeSmall + margin/2
        
        notesLabel = UILabel()
        notesLabel?.font = UIFont(name: "Helvetica", size: fontSizeSmall)?.italic
        notesLabel?.textColor = UIColor.darkGray
        notesLabel?.sizeToFit()
        notesLabel?.frame.origin = CGPoint(x: margin, y: y)
        notesLabel?.frame.size = CGSize(width: self.frame.width, height: fontSizeSmall + 2)
        addSubview(notesLabel!)
    }

}
