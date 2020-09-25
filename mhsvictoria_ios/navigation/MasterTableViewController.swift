//
//  MasterTableViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-16.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit
import AppointmentKit

class MasterTableViewController: UITableViewController, AppointmentDelegate {
    
    var appointments: Array<Appointment?>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.barTintColor = toolbarColor
        
        // read all of the appointments for the next 2 weeks
        let appointmentManager = AppointmentManager(appointmentDelegate: self)
        appointments = appointmentManager.retrieveAllAppointmentsFor(daysAhead: 31, filteredOn: nil)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if appointments != nil && !appointments!.isEmpty {
                return appointments!.count
            }
        }
        return 1 // this will increase with the resources.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
            cell.textLabel?.text = NSLocalizedString("cell.personal.preferences", comment: "")
            cell.section = indexPath.section
            return cell
        }
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                cell.textLabel?.text = NSLocalizedString("cell.appointment.management", comment: "")
                cell.textLabel?.font = UIFont(name: "Helvetica", size: fontSizeMed)?.boldItalic
                cell.section = indexPath.section
                
                cell.accessoryView = UIImageView(image: UIImage(systemName: "calendar.badge.plus"))
                cell.accessoryView?.tintColor = backgroundColor
                return cell
            } else if appointments != nil && !appointments!.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! AppointmentCell
                let appointment = appointments?[indexPath.row - 1]
                cell.textLabel?.text = appointment?.title
                cell.accessoryView = UIImageView(image: UIImage(systemName: "calendar.circle"))
                cell.accessoryView?.tintColor = backgroundColor
                if let _ = appointment?.notes {
                    cell.desc = appointment?.notes
                }
                cell.dateStr = ViewUtil.formatStartEndTime(appointment)
                return cell
            }
        }
        return tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row > 0 {
            return 52
        }
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
    
    func onAppointmentAction(appointment: Appointment, action: AppointmentAction) {
        
    }
    
    func onAppointmentError(error: String, action: AppointmentAction, id: String?) {
        
    }
    
}
