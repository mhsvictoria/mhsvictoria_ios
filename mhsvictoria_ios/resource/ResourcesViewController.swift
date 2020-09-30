//
//  ResourcesViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-30.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var remoteResources: Array<Resource?>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        ResourceManager.shared.retrieveRemoteResources(completion: {(_ success: Bool) in
            if success {
                self.remoteResources = ResourceManager.shared.remoteResources
                self.tableView.reloadData()
            } else {
                // ERROR!
            }
        })
   
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

extension ResourcesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = remoteResources {
            return remoteResources!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "resourcesCell", for: indexPath) as! ResourcesCell
        cell.textLabel?.text = remoteResources?[indexPath.row]?.name
        return cell
        
    }
    
    
    
}
