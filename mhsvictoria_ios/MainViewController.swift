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
        view.backgroundColor = background
        header.backgroundColor = toolbar
        let yOffset = header.frame.minY + header.frame.height + 20
        containerView.frame = CGRect(x: 20, y: yOffset, width: view.frame.width - 40, height: view.frame.height - yOffset - 80)
        
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
