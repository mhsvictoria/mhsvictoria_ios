//
//  ResourceResultCell.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-03-21.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class ResourceResultCell: UIView {

    private var resource: Resource?
    weak var delegate: ResourceCellDelegate?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    init(_ resource: Resource) {
        super.init(frame: .zero)
        commmonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commmonInit() {
        Bundle.main.loadNibNamed("ResourceResultCell", owner: self, options: nil)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.frame = bounds
        setUpView()
    }
    
    private func setUpView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellWasTapped))
        addGestureRecognizer(tapGesture)
        bottomLabel.text = resource?.name
    }
    
    @objc private func cellWasTapped() {
        delegate?.cellWasSelected(with: resource)
    }
}


protocol ResourceCellDelegate: class {
    func cellWasSelected(with resource: Resource?)
}
