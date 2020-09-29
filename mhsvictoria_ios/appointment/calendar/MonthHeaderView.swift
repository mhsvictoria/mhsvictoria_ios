//
//  MonthHeaderView.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-29.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

protocol NavigationDelegate {
    func onLeftNav()
    func onRightNav()
}

class MonthHeaderView: UIView {

    var navigationDelegate: NavigationDelegate?
    var leftNav: UIButton?
    var rightNav: UIButton?
    var monthLabel: UILabel?
    var month: String? {
        didSet {
            if(monthLabel == nil) {
                monthLabel = UILabel()
                monthLabel?.textColor = UIColor.darkGray
                monthLabel?.font = UIFont(name: fontName, size: fontSizeLarge)
                monthLabel?.textAlignment = .center
                leftNav = UIButton()
                leftNav?.addTarget(self, action: #selector(onLeftNav), for: .touchUpInside)
                leftNav?.setImage(UIImage(systemName: "chevron.left"), for: .normal)
                rightNav = UIButton()
                rightNav?.setImage(UIImage(systemName: "chevron.right"), for: .normal)
                addSubview(monthLabel!)
                monthLabel!.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    monthLabel!.leadingAnchor.constraint(equalTo: leadingAnchor),
                    monthLabel!.trailingAnchor.constraint(equalTo: trailingAnchor),
                    monthLabel!.topAnchor.constraint(equalTo: topAnchor),
                    monthLabel!.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
                addSubview(leftNav!)
                leftNav!.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    leftNav!.leadingAnchor.constraint(equalTo: leadingAnchor),
                    leftNav!.widthAnchor.constraint(equalToConstant: 64),
                    leftNav!.centerYAnchor.constraint(equalTo: centerYAnchor),
                    leftNav!.heightAnchor.constraint(equalToConstant: 44)
                ])
                
                rightNav?.addTarget(self, action: #selector(onRightNav), for: .touchUpInside)
                addSubview(rightNav!)
                rightNav!.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    rightNav!.trailingAnchor.constraint(equalTo: trailingAnchor),
                    rightNav!.widthAnchor.constraint(equalToConstant: 64),
                    rightNav!.centerYAnchor.constraint(equalTo: centerYAnchor),
                    rightNav!.heightAnchor.constraint(equalToConstant: 44)
                ])
            }
            monthLabel?.text = month
        }
    }
    
    @objc func onLeftNav() {
        navigationDelegate?.onLeftNav()
    }
    
    @objc func onRightNav() {
        navigationDelegate?.onRightNav()
    }
}
