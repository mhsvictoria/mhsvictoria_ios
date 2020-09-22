//
//  AppointmentCell.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-28.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

class AppointmentCell: UITableViewCell {

    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var urlLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLabels()
    }
    
    private func initLabels() {
        titleLabel = UILabel(frame: CGRect(x: 10, y: 8, width: self.frame.width - 20, height: 24))
        titleLabel?.font = UIFont(name: fontName, size: fontSizeMed)
        titleLabel?.textColor = UIColor.darkText
        addSubview(titleLabel!)
        
        descriptionLabel = UILabel(frame: CGRect(x: 10, y: 32, width: self.frame.width - 20, height: 21))
        descriptionLabel?.font = UIFont(name: fontName, size: fontSizeSmall)
        descriptionLabel?.textColor = UIColor.green
        addSubview(descriptionLabel!)
        
        urlLabel = UILabel(frame: CGRect(x: 10, y: 60, width: self.frame.width - 20, height: 21))
        urlLabel?.font = UIFont(name: fontName, size: fontSizeSmall)
        urlLabel?.textColor = UIColor.blue
        addSubview(urlLabel!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        initLabels()
    }

}
