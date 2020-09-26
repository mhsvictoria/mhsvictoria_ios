//
//  MhsgvTableViewCell.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-16.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class MhsgvTableViewCell: UITableViewCell {

    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.textAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
