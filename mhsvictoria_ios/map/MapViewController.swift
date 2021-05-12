//
//  MapViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-25.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapActionBar: MapActionBar!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapActionBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapActionBar.heightAnchor.constraint(equalToConstant: toolbarHeight),
            mapActionBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapActionBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapActionBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        mapActionBar.backgroundColor = toolbarColor
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapActionBar.topAnchor)
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
