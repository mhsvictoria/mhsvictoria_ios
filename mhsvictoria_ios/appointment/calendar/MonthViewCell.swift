//
//  MonthViewCell.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-12.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

class MonthViewCell: UICollectionViewCell {
    
    var timeSpan: TimeSpan?
    var title: UILabel!
    var month: Int = 0 // January
    var year: Int = 0 // 2019
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title = UILabel(frame: CGRect(x: 0, y: 2, width: frame.width, height: 16))
        title.textColor = UIColor.darkGray
        title.font = UIFont(name: fontName, size: fontSizeSmall)
        title.textAlignment = .center
        addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
