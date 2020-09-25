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
    var resources: Array<Resource?>?
    var mappedResources: Array<Resource?>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = toolbarColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appointmentManager = AppointmentManager(appointmentDelegate: self)
        appointments = appointmentManager.retrieveAllAppointmentsFor(daysAhead: 31, filteredOn: "filtered")
        
        let resourceManager = ResourceManager()
        resources = resourceManager.retrieveAllResources()
        
        mappedResources = resourceManager.retrieveAllMappedResources()
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section) {
        case 0:
            if resources != nil && !resources!.isEmpty {
                return resources!.count + 1
            } else {
                return 2
            }
        case 1:
            if appointments != nil && !appointments!.isEmpty {
                return appointments!.count + 1
            } else {
                return 2
            }
        default:
            if mappedResources != nil && !mappedResources!.isEmpty {
                return mappedResources!.count + 1
            } else {
                return 1
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // SECTION 0
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                cell.textLabel?.text = NSLocalizedString("cell.personal.preferences", comment: "")
                cell.textLabel?.font = createFont
                cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.turn.up.right"))
                cell.accessoryView?.tintColor = primaryDark
                cell.section = indexPath.section
                return cell
            } else {
                if resources != nil, !resources!.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                    cell.textLabel?.text = resources?[indexPath.row - 1]?.name
                    cell.textLabel?.font = cellFont
                    cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
                    cell.section = indexPath.section
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                    cell.textLabel?.text = "resource.placeholder".localized
                    cell.textLabel?.font = cellFont?.italic
                    cell.textLabel?.textColor = textLight
                    return cell
                }
            }
        }
        
        // SECTION 1
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                cell.textLabel?.text = NSLocalizedString("cell.appointment.management", comment: "")
                cell.textLabel?.font = createFont
                cell.section = indexPath.section
                cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.turn.up.right"))
                cell.accessoryView?.tintColor = primaryDark
                return cell
            } else {
                if appointments != nil && !appointments!.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! AppointmentCell
                    let appointment = appointments?[indexPath.row - 1]
                    cell.title = appointment?.title
                    cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
                    cell.accessoryView?.tintColor = primaryDark
                    cell.dateStr = ViewUtil.formatStartEndDate(appointment)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                    cell.textLabel?.text = "appointment.placeholder".localized
                    cell.textLabel?.font = cellFont?.italic
                    cell.textLabel?.textColor = textLight
                    return cell
                }
            }
        }
        
        // SECTION 1
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                cell.textLabel?.text = NSLocalizedString("cell.map.management", comment: "")
                cell.textLabel?.font = createFont
                cell.section = indexPath.section
                cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.turn.up.right"))
                cell.accessoryView?.tintColor = primaryDark
                return cell
            } /*else {
                if mappedResources != nil && !mappedResources!.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! AppointmentCell
                    let mappedResource = mappedResources?[indexPath.row - 1]
                    cell.title = mappedResource?.name
                    cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
                    cell.accessoryView?.tintColor = backgroundColor
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                    cell.textLabel?.text = "location.placeholder".localized
                    cell.textLabel?.font = cellFont?.italic
                    cell.textLabel?.textColor = textLight
                    return cell
                }
            }*/
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
            headerView.buttonName = "magnifyingglass"
            headerView.title = NSLocalizedString("section.resource.search", comment: "")
        }
        if section == 1 {
            headerView.buttonName = "calendar"
            headerView.title = NSLocalizedString("section.appointments", comment: "")
        }
        
        if section == 2 {
            headerView.buttonName = "map"
            headerView.title = NSLocalizedString("section.map", comment: "")
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
            if indexPath.row == 0 {
                AppointmentManager.selected = nil
            } else {
                let appointment = appointments?[indexPath.row - 1]
                AppointmentManager.selected = appointment
            }
            self.navigationController?.performSegue(withIdentifier: "appointmentSegue", sender: self)
            break
        default:
            if indexPath.row > 0 {
                let appointment = appointments?[indexPath.row - 1]
                AppointmentManager.selected = appointment
            }
            self.navigationController?.performSegue(withIdentifier: "mapSegue", sender: self)
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
        if segue.identifier == "mapSegue" {
            present(MapViewController(), animated: true, completion: nil)
        }
    }
    
    func onAppointmentAction(appointment: Appointment, action: AppointmentAction) {
        
    }
    
    func onAppointmentError(error: String, action: AppointmentAction, id: String?) {
        
    }
    
}
