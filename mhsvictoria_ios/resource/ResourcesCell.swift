//
//  ResourcesCell.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-30.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

protocol MapPinDelegate {
    func onMapPinSelect(mapTarget: String?)
}
class ResourcesCell: UITableViewCell {

    var mapIcon: UIImageView?
    var mapTarget: String?
    var mapPinDelegate: MapPinDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapIcon = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
        mapIcon?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapIcon!)
        mapIcon?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        mapIcon?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mapIcon?.widthAnchor.constraint(equalToConstant: margin).isActive = true
        mapIcon?.heightAnchor.constraint(equalToConstant: margin).isActive = true
        mapIcon?.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onMapPinClick(_:)))
        mapIcon?.addGestureRecognizer(gestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func onMapPinClick(_ sender: UIImageView) {
        mapPinDelegate?.onMapPinSelect(mapTarget: mapTarget)
    }
}
