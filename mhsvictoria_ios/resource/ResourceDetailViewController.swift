//
//  ResourceDetailViewController.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2020-10-24.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class ResourceDetailViewController: UIViewController {

    var resourceData: Resource?
    let resourceDetailView = ResourceDetailsView()
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        resourceDetailView.data = resourceData
        setUpView()
    }
    
    func setUpView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin)
        ])
        view.backgroundColor = darkSlateGrey
        scrollView.addSubview(resourceDetailView)
        scrollView.layer.borderWidth = 2
        scrollView.layer.borderColor = slateGrey.cgColor
        scrollView.layer.cornerRadius = 5
        scrollView.backgroundColor = lightSlateGrey

        resourceDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resourceDetailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            resourceDetailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            resourceDetailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            resourceDetailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            resourceDetailView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -2 * margin)
        ])
    }
}
