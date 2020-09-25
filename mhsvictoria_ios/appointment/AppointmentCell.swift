//
//  AppointmentCell.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-28.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

class AppointmentCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var title: String?  {
        didSet {
            if titleLabel == nil {
                titleLabel = UILabel(frame: CGRect(x: margin, y: marginSmall, width: self.frame.width - margin, height: fontSizeMed))
                titleLabel?.font = cellFont
                titleLabel?.textColor = UIColor.darkText
                addSubview(titleLabel!)
            }
            titleLabel?.text = title
        }
    }
        
    var dateLabel: UILabel!
    var dateStr: String? {
        didSet {
            if dateLabel == nil {
                dateLabel = UILabel(frame: CGRect(x: margin, y: fontSizeLarge + marginSmall, width: self.frame.width - marginLrg, height: fontSizeMedLarge))
                dateLabel?.font = UIFont(name: fontName, size: fontSizeSmall)
                dateLabel?.textAlignment = .right
                dateLabel?.textColor = textLight
                addSubview(dateLabel!)
            }
            dateLabel?.text = dateStr
        }
    }
}
