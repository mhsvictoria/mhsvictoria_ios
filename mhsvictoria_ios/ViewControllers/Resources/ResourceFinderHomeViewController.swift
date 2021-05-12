//
//  ResourceFinderHomeViewController.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-01-16.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class ResourceFinderHomeViewController: UIViewController {

    @IBOutlet weak var myselfButton: UIButton!
    @IBOutlet weak var someoneElseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    private func setUpView() {
        myselfButton.layer.cornerRadius = 10
        someoneElseButton.layer.cornerRadius = 10
    }
    

    

}
