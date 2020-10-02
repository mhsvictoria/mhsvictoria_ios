//
//  MasterTableViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-16.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit
import AppointmentKit

class MasterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AppointmentDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appointments: Array<Appointment?>?
    var resources: Array<Resource?>?
    var mappedResources: Array<Resource?>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.barTintColor = toolbarColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appointmentManager = AppointmentManager(appointmentDelegate: self)
        appointments = appointmentManager.retrieveAllAppointmentsFor(daysAhead: 31, filteredOn: "filtered")
        
        resources = ResourceManager.shared.retrieveAllResources()
        mappedResources = ResourceManager.shared.retrieveAllMappedResources()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section) {
        case 0:
            var total = 2
            if resources != nil && !resources!.isEmpty {
                total = total + resources!.count
            }
            return total
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
                return 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // SECTION 0
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return firstCellInSection(text: "cell.personal.preferences".localized, indexPath: indexPath)
            } else if resources != nil, !resources!.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
                cell.textLabel?.text = resources?[indexPath.row - 1]?.name
                cell.textLabel?.font = cellFont
                cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
                cell.section = indexPath.section
                return cell
            } else {
                return placeHolderForIndexPath(text: "resource.placeholder".localized, indexPath: indexPath)
            }
            
        }
        
        // SECTION 1
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                return firstCellInSection(text: "cell.appointment.management".localized, indexPath: indexPath)
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
                    return placeHolderForIndexPath(text: "appointment.placeholder".localized, indexPath: indexPath)
                }
            }
        }
        
        // SECTION 2
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                return firstCellInSection(text: "cell.map.management".localized, indexPath: indexPath)
            } else {
                if mappedResources != nil && !mappedResources!.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! AppointmentCell
                    let mappedResource = mappedResources?[indexPath.row - 1]
                    cell.title = mappedResource?.name
                    cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
                    cell.accessoryView?.tintColor = primaryDark
                    return cell
                } else {
                    let cell =  placeHolderForIndexPath(text: "location.placeholder".localized, indexPath: indexPath)
                    cell.accessoryView = nil
                    
                    return cell
                }
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row > 0 {
            return 52
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight), header: "section.resource.search".localized, font: sectionHeaderFont, color: toolbarColor)
            headerView.buttonName = "magnifyingglass"
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onResourcesClick))
            headerView.addGestureRecognizer(gesture)
            return headerView
        }
        if section == 1 {
            let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight), header: "section.appointments".localized, font: sectionHeaderFont, color: toolbarColor)
            headerView.buttonName = "calendar"
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onCalendarClick))
            headerView.addGestureRecognizer(gesture)
            return headerView
        }
        
        if section == 2 {
            let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight), header: "section.map".localized, font: sectionHeaderFont, color: toolbarColor)
            headerView.buttonName = "map"
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onMapClick))
            headerView.addGestureRecognizer(gesture)
            return headerView
        }
        return nil
    }
    
    @objc func onCalendarClick(_ sender: UIButton) {
        self.navigationController?.performSegue(withIdentifier: "calendarSegue", sender: self)
    }
    
    @objc func onResourcesClick(_ sender: UIButton) {
        self.navigationController?.performSegue(withIdentifier: "resourcesSegue", sender: self)
    }
    
    @objc func onMapClick(_ sender: UIButton) {
        self.navigationController?.performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.section) {
        case 0:
            if indexPath.row == 0 {
                self.navigationController?.performSegue(withIdentifier: "formSegue", sender: self)
            } else {
                if resources != nil && !resources!.isEmpty {
                    // todo: Add resources
                    //let resource = resources?[indexPath.row - 1]
                    //ResourceManager.selected = resource
                    self.navigationController?.performSegue(withIdentifier: "formSegue", sender: self)
                }
            }
            break
        case 1:
            if indexPath.row == 0 {
                AppointmentManager.selected = nil
                self.navigationController?.performSegue(withIdentifier: "appointmentSegue", sender: self)
            } else {
                if appointments != nil && !appointments!.isEmpty {
                    let appointment = appointments?[indexPath.row - 1]
                    AppointmentManager.selected = appointment
                    self.navigationController?.performSegue(withIdentifier: "appointmentSegue", sender: self)
                }
            }
            break
        default:
            if indexPath.row == 0 {
                self.navigationController?.performSegue(withIdentifier: "mapSegue", sender: self)
            } else {
                if appointments != nil && !appointments!.isEmpty {
                    let appointment = appointments?[indexPath.row - 1]
                    AppointmentManager.selected = appointment
                    self.navigationController?.performSegue(withIdentifier: "mapSegue", sender: self)
                }
            }
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
        if  segue.identifier == "resourcesSegue" {
            present(ResourcesViewController(), animated: true, completion: nil)
        }
        if segue.identifier == "appointmentSegue" {
            present(AppointmentViewController(), animated: true, completion: nil)
        }
        if segue.identifier == "mapSegue" {
            present(MapViewController(), animated: true, completion: nil)
        }
        if segue.identifier == "calendarSegue" {
            present(MonthViewController(), animated: true, completion: nil)
        }
    }
    
    func onAppointmentAction(appointment: Appointment, action: AppointmentAction) {
        
    }
    
    func onAppointmentError(error: String, action: AppointmentAction, id: String?) {
        
    }
    
    private func firstCellInSection(text: String, indexPath: IndexPath) -> MhsgvTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
        cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.turn.up.right"))
        cell.accessoryView?.tintColor = primaryDark
        cell.section = indexPath.section
        cell.textLabel?.text = text
        cell.textLabel?.font = createFont
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    
    private func placeHolderForIndexPath(text: String, indexPath: IndexPath) -> MhsgvTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mhsgvCell", for: indexPath) as! MhsgvTableViewCell
        cell.textLabel?.text = text
        cell.textLabel?.font = cellFont?.italic
        cell.textLabel?.textColor = textLight
        return cell
    }
}
