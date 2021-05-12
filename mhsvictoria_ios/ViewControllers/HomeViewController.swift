//
//  HomeViewController.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-01-16.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func brainButtonPressed(sender: UIButton) {
        
        if let tabBar = tabBarController, sender.tag < (tabBar.viewControllers?.count ?? 0) {
            tabBarController?.selectedIndex = sender.tag
        }
    }

}
