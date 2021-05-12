//
//  ResultsViewController.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2021-03-27.
//  Copyright © 2021 Ron Allan. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsContainer: UIStackView!
    
    public var rankedResults: [Resource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addResults()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    

    private func addResults() {
        
        
        
    }

}
