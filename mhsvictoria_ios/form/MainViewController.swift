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
    var pageViewController: MhsgvPageViewController? = nil
    let pageControl = CustomPageControl()
    //NEW CODE END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        header.backgroundColor = toolbarColor
        
        //TODO add page control constraints
        
        /*
        let lineImage = UIImageView(image: drawLine())
        view.addSubview(lineImage)
        
        
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineImage.topAnchor.constraint(equalTo: header.bottomAnchor, constant: margin + 2 + dotSize / 2)
        ])
        
        pageButtons.pageIndicatorTintColor = dark_grey
        pageButtons.numberOfPages = 3
        pageButtons.setIndicatorImage(drawCircle(num: 0, selected: false), forPage: 0)
        pageButtons.setIndicatorImage(drawCircle(num: 1, selected: false), forPage: 1)
        pageButtons.setIndicatorImage(drawCircle(num: 2, selected: false), forPage: 2)
        view.addSubview(pageButtons)
        pageButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            pageButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            pageButtons.topAnchor.constraint(equalTo: header.bottomAnchor, constant: margin)
        ])
        //pageButtons.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        pageButtons.addTarget(self, action: #selector(self.valueChange), for: .valueChanged)
        */
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
    
    
    @objc func valueChange(_ sender: UIPageControl) {
        print(sender.currentPage)
        if let pvc = pageViewController {
            pvc.currentSelection = sender.currentPage
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.pageViewController = segue.destination as? MhsgvPageViewController
        self.pageViewController.pageControl = pageControl
    }
}
