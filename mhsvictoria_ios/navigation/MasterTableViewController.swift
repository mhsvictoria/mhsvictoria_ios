//
//  MasterTableViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-16.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return 1 // this will increase with the resources.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = NSLocalizedString("cell.personal.preferences", comment: "")
        }
        if indexPath.section == 1 {
            cell.textLabel?.text = NSLocalizedString("cell.appointment.management", comment: "")
        }
        cell.section = indexPath.section
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight))
        if section == 0 {
        headerView.title = NSLocalizedString("section.resource.search", comment: "")
        }
        if section == 1 {
            headerView.title = NSLocalizedString("section.appointments", comment: "")
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.section) {
        case 0:
            self.navigationController?.performSegue(withIdentifier: "formSegue", sender: self)
            break
        case 1:
            self.navigationController?.performSegue(withIdentifier: "appointmentSegue", sender: self)
            break
        default:
            break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "formSegue" {
            present(MainViewController(), animated: true, completion: nil)
        }
        if segue.identifier == "appointmentSegue" {
            present(AppointmentViewController(), animated: true, completion: nil)
        }
    }
    

}
