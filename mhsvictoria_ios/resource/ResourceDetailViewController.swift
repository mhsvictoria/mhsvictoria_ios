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
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        resourceDetailView.data = resourceData
    }

    func setUpView() {
        view.backgroundColor = darkSlateGrey
        view.addSubview(resourceDetailView)
        resourceDetailView.layer.borderWidth = 2
        resourceDetailView.layer.borderColor = slateGrey.cgColor
        resourceDetailView.layer.cornerRadius = 5

        resourceDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resourceDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            resourceDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            resourceDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            resourceDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin)
        ])
    }
}
