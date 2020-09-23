//
//  MainViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var containerView: UIView!
    var pageViewController: MhsgvPageViewController? = nil
    let pageControl = CustomPageControl(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        header.backgroundColor = toolbarColor
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = true
        view.bringSubviewToFront(pageControl)
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            pageControl.topAnchor.constraint(equalTo: header.bottomAnchor, constant: margin),
            pageControl.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: toolbarOffset),
            header.heightAnchor.constraint(equalToConstant: toolbarHeight)
        ])
        
        let yOffset = header.frame.minY + header.frame.height + margin
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: yOffset + margin),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -(yOffset + marginLrg))
            ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.pageViewController = segue.destination as? MhsgvPageViewController
        self.pageViewController!.pageControl = pageControl
        pageControl.delegate = self.pageViewController
    }
}
