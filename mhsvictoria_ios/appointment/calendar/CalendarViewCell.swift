//
//  CalendarViewCell.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-12.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit

class CalendarViewCell: UITableViewCell {

    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel(frame: CGRect(x: 16, y: 4, width: frame.width/2, height: 21))
        addSubview(titleLabel)
        // layout description label
        descriptionLabel = UILabel(frame: CGRect(x: 16, y: frame.height - 20, width: frame.width - 40, height: 16))
        addSubview(descriptionLabel)
        // layout imageView (default)
        // layout accessory (default)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
