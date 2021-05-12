//
//  ResourcesViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-30.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController, MapPinDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var remoteResources: Dictionary<String, Array<Resource>?>?
    var resourceKeys: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    func onMapPinSelect(mapTarget: String?) {
        self.navigationController?.performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "mapSegue" {
            present(MapViewController(), animated: true, completion: nil)
        }
     }
}

extension ResourcesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = resourceKeys {
            return resourceKeys!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _ =  resourceKeys else {
            return 0
        }
        if let key = resourceKeys?[section] {
            if let arr = remoteResources?[key] {
                return arr!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourcesCell", for: indexPath) as! ResourcesCell
        
        if let key = resourceKeys?[indexPath.section] {
            if let arr = remoteResources?[key] {
                cell.textLabel?.text = arr?[indexPath.row].name
                cell.mapTarget = arr?[indexPath.row].name
                cell.mapPinDelegate = self
            }
        }
        cell.textLabel?.font = cellFont
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let key = resourceKeys?[indexPath.section] {
            if let resourceDataArray = remoteResources?[key] {
                if let resourceData = resourceDataArray?[indexPath.row] {
                    let detailVC = ResourceDetailViewController()
                    detailVC.resourceData = resourceData
                    show(detailVC, sender: self)
                    
                }
            }
        }
    }
}

