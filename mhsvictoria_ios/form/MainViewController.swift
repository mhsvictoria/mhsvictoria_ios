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
    //NEW CODE
    let pageButtons = UIPageControl()
    let imageView = UIImageView(image: UIImage(named: "brain_sm.png"))
    let imageView2 = UIImageView(image: UIImage(named: "brain_sm.png"))
    //NEW CODE END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        header.backgroundColor = toolbarColor
        
        print(containerView.subviews[0].subviews)
        
        
        //TODO NEW CODE HERE
        
    
        print(pageButtons.subviews)
        
        pageButtons.numberOfPages = 3
        view.addSubview(pageButtons)
        pageButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            pageButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            pageButtons.topAnchor.constraint(equalTo: header.bottomAnchor, constant: margin)
        ])
        pageButtons.addSubview(imageView)
        pageButtons.addSubview(imageView2)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView2.leadingAnchor.constraint(equalTo: pageButtons.leadingAnchor),
            imageView2.topAnchor.constraint(equalTo: pageButtons.topAnchor)
        ])
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: pageButtons.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: pageButtons.topAnchor)
        ])
        view.bringSubviewToFront(pageButtons)
        
        //NEW CODE END
        
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
}
