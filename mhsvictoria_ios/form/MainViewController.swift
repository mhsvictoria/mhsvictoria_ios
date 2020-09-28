//
//  MainViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var pageViewController: MhsgvPageViewController? = nil
    let pageControl = CustomPageControl(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }
    
    override func viewWillLayoutSubviews() {
           
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100 +  pageControlHeight),
            containerView.heightAnchor.constraint(equalToConstant: view.frame.height/2)
        ])
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = true
        view.bringSubviewToFront(pageControl)
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            pageControl.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -margin),
            pageControl.heightAnchor.constraint(equalToConstant: pageControlHeight)
        ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.pageViewController = segue.destination as? MhsgvPageViewController
        self.pageViewController!.pageControl = pageControl
        pageControl.delegate = self.pageViewController
    }

}
