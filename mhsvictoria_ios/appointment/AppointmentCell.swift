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
                titleLabel = UILabel(frame: CGRect(x: margin, y: 0, width: self.frame.width - margin, height: fontSizeMed))
                titleLabel?.font = UIFont(name: fontName, size: fontSizeMed)
                titleLabel?.textColor = UIColor.darkText
                addSubview(titleLabel!)
            }
            titleLabel?.text = title
        }
    }
    
    var descriptionLabel: UILabel?
    var desc: String? {
        didSet {
            if descriptionLabel == nil {
                descriptionLabel = UILabel(frame: CGRect(x: margin, y: fontSizeLarge + marginSmall, width: self.frame.width - marginLrg, height: fontSizeMedLarge))
                descriptionLabel?.font = UIFont(name: fontName, size: fontSizeSmall)
                descriptionLabel?.textColor = textLight
                addSubview(descriptionLabel!)
            }
            descriptionLabel?.text = desc
        }
    }
    
    var dateLabel: UILabel!
    var dateStr: String? {
        didSet {
            if dateLabel == nil {
                dateLabel = UILabel(frame: CGRect(x: frame.width/2, y: marginSmall, width: self.frame.width/2 - marginLrg, height: frame.height -  margin))
                dateLabel?.font = UIFont(name: fontName, size: fontSizeSmall)
                dateLabel?.textAlignment = .right
                addSubview(dateLabel!)
            }
            dateLabel?.text = dateStr
        }
    }
}
