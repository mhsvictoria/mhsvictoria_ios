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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        header.backgroundColor = toolbarColor
    }
    
    override func viewWillLayoutSubviews() {
        header.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: toolbarOffset),
            header.heightAnchor.constraint(equalToConstant: toolbarHeight)
        ])
        let image = UIImage(named: "brain_sm.png")
        let imageView = UIImageView(image: image)
        header.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: header.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: header.heightAnchor)
        ])
        
        let yOffset = header.frame.minY + header.frame.height + margin
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: yOffset),
            containerView.heightAnchor.constraint(equalToConstant: view.frame.height/2)
        ])
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

