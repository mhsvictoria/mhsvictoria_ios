//
//  CalendarViewController.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-06.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import EventKit
import AppointmentKit

class CalendarViewController: UIViewController, CalendarEntryDelegate, UIGestureRecognizerDelegate, AppointmentDelegate {

    var appointmentManager: AppointmentManager? = nil
    
    var headerView: UIView?
    var calendarsTableView: CalendarsTableView!
    var monthsCollectionView: MonthsCollectionView!
    var calendarEntryDelegate: CalendarEntryDelegate?
    
    let calendarReuseIdentifier = "calendarCell"
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refreshCalendars(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.green
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentManager = AppointmentManager(appointmentDelegate: self)
        initTable()
        initCollection()
        monthsCollectionView?.calendarEntryDelegate = self
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            calendarsTableView.refreshControl = refreshControl
        } else {
            calendarsTableView.addSubview(refreshControl)
        }
        
        let backBtn = UIBarButtonItem(image: UIImage(named: "Back"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBtn
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func notify(_ appointmentAction: AppointmentAction) {
    }
    
    @objc func refreshCalendars(_ sender: UIRefreshControl) {
        refreshTableView()
        refreshCollectionView()
        sender.endRefreshing()
    }
    
    func onCalendarEntrySelected(_ calendarEntry: CalendarEntry) {
        /*
        appointmentManager.retrieveEventsFor(calendarEntry: CalendarUtil.calendarEntryFor(month: monthYear.0, year: monthYear.1))
 */
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "monthPageController") as! MonthPageController
        //vc.initialMonthYear = (1, 2019)
        self.show(vc, sender: self)
 
        //calendarEntryDelegate?.onCalendarEntrySelected(calendarEntry)
    }
    
    func onAppointmentAction(appointment: Appointment, action: AppointmentAction) {
        switch(action) {
        case .make:
            break
        case .read:
            break
        case .update:
            break
        case .cancel:
            break
        case .select:
            break
        case .completed:
            break
        }
    }
    
    func onAppointmentError(error: String, action: AppointmentAction, id: String?) {
        switch(action) {
        case .make:
            break
        case .read:
            break
        case .update:
            break
        case .cancel:
            break
        case .select:
            break
        case .completed:
            break
        }
    }
    
    private func initTable() {
        calendarsTableView = CalendarsTableView(frame: CGRect(x: 8, y: 8, width: self.view.frame.width - 16, height: self.view.frame.height/3))
        calendarsTableView.register(CalendarViewCell.self, forCellReuseIdentifier: calendarReuseIdentifier)
        self.view.addSubview(calendarsTableView)
        calendarsTableView.delegate = self
        calendarsTableView.dataSource = self
        self.view.addSubview(calendarsTableView)
    }
    
    private func initCollection() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 180, height: 160)
        flowLayout.scrollDirection = .vertical
        let y: CGFloat = 16 + self.view.frame.height/3
        let collectionFrame = CGRect(x: 8, y: y, width: self.view.frame.width - 20, height: self.view.frame.height - y - 16)
        monthsCollectionView = MonthsCollectionView(frame: collectionFrame, collectionViewLayout: flowLayout)
        monthsCollectionView.calendarEntryDelegate = self
        monthsCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(monthsCollectionView)
    }
    
    private func refreshTableView() {
        calendarsTableView.reloadData()
    }
    
    private func refreshCollectionView() {
        monthsCollectionView.reloadData()
    }
    
    private func fetchReminders() {
        
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

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = appointmentManager?.calendars else {
            return 0
        }
        return (appointmentManager?.calendars?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: calendarReuseIdentifier, for: indexPath) as! CalendarViewCell
        if let calendars = appointmentManager?.calendars {
            let calendarName = calendars[(indexPath as NSIndexPath).row].title
            cell.titleLabel?.text = calendarName
            cell.descriptionLabel?.text = "A description"
        } else {
            cell.titleLabel?.text = "Unknown Calendar Name"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView = UIView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
/*
extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthReuseIdentifier, for: indexPath) as! MonthViewCell
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
}
 */
