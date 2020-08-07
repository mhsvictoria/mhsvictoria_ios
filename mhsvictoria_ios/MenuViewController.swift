//
//  MenuViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-01.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var brainImage: UIImageView!
    @IBOutlet weak var crisisButton: UIButton!
    
    @IBOutlet weak var findResourcesButton: UIButton!
    @IBOutlet weak var newsletterButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        findResourcesButton.titleLabel?.numberOfLines = 2
        findResourcesButton.titleLabel?.textAlignment = .center
        brainImage.isHighlighted = true
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
