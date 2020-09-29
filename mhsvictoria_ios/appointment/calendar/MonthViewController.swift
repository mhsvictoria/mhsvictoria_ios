//
//  MonthViewController.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-13.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit



class MonthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AppointmentDelegate, AppointmentSelectionDelegate, NavigationDelegate {
    
    let NUM_DAYS = 7
    let NUM_WEEKS = 6
    let reuseIdentifier = "dayCollectionViewCell"
    
    var month: Int = CalendarUtil.calendarEntryForToday().month
    var year: Int = CalendarUtil.calendarEntryForToday().year
    
    @IBOutlet weak var daysCollectionView: DaysCollectionView!
    @IBOutlet weak var monthHeaderView: MonthHeaderView!
    
    @IBOutlet weak var appointmentDetailsView: AppointmentDetailsView!
    @IBOutlet weak var editButton: UIButton!
    
    private let sectionInsets = UIEdgeInsets(top: 0.0,
                                             left: 0.0,
                                             bottom: 0.0,
                                             right: 0.0)
    private let itemsPerRow: CGFloat = 7
    private var monthArr: Array<MonthDayYear>?
    private var currentSelected: IndexPath?
    
    
    var appointmentsThisMonth: Array<Appointment?>?
    var appointmentsLastMonth: Array<Appointment?>?
    var appointmentsNextMonth: Array<Appointment?>?
    
    var index: Int?
    var calendarEntry: CalendarEntry? {
        didSet {
            monthArr = CalendarUtil.calendarArrayFor(calendarEntry: calendarEntry!)
            daysCollectionView.reloadData()
            currentSelected = nil
        }
    }
    
    var currentMonth: String?
    var calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysCollectionView.dataSource = self
        daysCollectionView.delegate = self
        calendarEntry = CalendarUtil.calendarEntryForToday()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        daysCollectionView.reloadData()
        currentSelected = nil
    }
    
    override func viewDidLayoutSubviews() {
        monthHeaderView.month = monthString(calendarEntry: calendarEntry(month: month, year: year))
        monthHeaderView.navigationDelegate = self
        monthHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            monthHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            monthHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            monthHeaderView.topAnchor.constraint(equalTo: view.topAnchor, constant: marginLrg),
            monthHeaderView.heightAnchor.constraint(equalToConstant: controlBarHeight)
        ])
        daysCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            daysCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            daysCollectionView.topAnchor.constraint(equalTo: monthHeaderView.bottomAnchor, constant: -marginSmall),
            daysCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - margin)
        ])
        
        appointmentDetailsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appointmentDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            appointmentDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            appointmentDetailsView.topAnchor.constraint(equalTo: daysCollectionView.bottomAnchor, constant: -margin),
            appointmentDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -marginMedLrg)
        ])
        appointmentDetailsView?.layer.cornerRadius = 8
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: appointmentDetailsView.trailingAnchor, constant: -marginSmall),
            editButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            editButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            editButton.topAnchor.constraint(equalTo: appointmentDetailsView.topAnchor, constant: marginSmall),
            
        ])
        editButton.setTitle("appointment.edit".localized, for: .normal)
        editButton.setTitleColor(primaryDark, for: .normal)
        editButton.setTitleColor(lightGrey, for: .selected)
        editButton.titleLabel?.font = buttonFont
        editButton.layer.cornerRadius = 8
        editButton.layer.borderColor = primaryDark.cgColor
        editButton.layer.borderWidth = 2

        //editButton?.isHidden = true
    }
    
    @IBAction func onEditAppointment(_ sender: UIButton) {
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let _ = monthArr else {
            return 0
        }
        
        let appointmentManager = AppointmentManager(appointmentDelegate: self)
        
        appointmentsLastMonth = appointmentManager.retrieveAllAppointmentsFor(month: (calendarEntry?.lastMonth)!, day: 1, year: (calendarEntry?.lastMonthYear)!, daysAhead: (calendarEntry?.numberOfDaysLastMonth)!, filteredOn: nil)
        
        appointmentsThisMonth = appointmentManager.retrieveAllAppointmentsFor(month: (calendarEntry?.month)!, day: 1, year: (calendarEntry?.year)!, daysAhead: (calendarEntry?.numberOfDaysThisMonth)!, filteredOn: nil)
        
        if let appts = appointmentsThisMonth {
            appointmentDetailsView.appointment = appts[0]
        }
        
        appointmentsNextMonth = appointmentManager.retrieveAllAppointmentsFor(month: (calendarEntry?.nextMonth)!, day: 1, year: (calendarEntry?.nextYear)!, daysAhead: (calendarEntry?.numberOfDaysThisMonth)!, filteredOn: nil)
        return (monthArr?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DayCollectionViewCell
        
        cell.monthDayYear = (monthArr?[indexPath.row])!
        // Need the appointment for today
        NSLog("Index Path row: \(indexPath.row) - for day: \(String(describing: monthArr?[indexPath.row].date))")
        if let appt = findApptOnSameDayFor(date: (monthArr?[indexPath.row].date)!) {
            cell.appointment = appt
            cell.appointmentSelectionDelegate = self
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _ = currentSelected {
            let selectedCell = collectionView.cellForItem(at: currentSelected!) as! DayCollectionViewCell
            selectedCell.unselectCell()
        }
        let dayCell = collectionView.cellForItem(at: indexPath) as! DayCollectionViewCell
        dayCell.selectCell()
        currentSelected = indexPath
    }
    
    func onAppointmentAction(appointment: Appointment, action: AppointmentAction) {
        
    }
    
    func onAppointmentError(error: String, action: AppointmentAction, id: String?) {
    }
    
    private func findApptOnSameDayFor(date: Date) -> Appointment? {
        for appt in appointmentsLastMonth! {
            if Calendar.current.isDate(date, inSameDayAs: (appt?.startTime)!) {
                return appt
            }
        }
        
        for appt in appointmentsThisMonth! {
            if Calendar.current.isDate(date, inSameDayAs: (appt?.startTime)!) {
                return appt
            }
        }
        
        for appt in appointmentsNextMonth! {
            if Calendar.current.isDate(date, inSameDayAs: (appt?.startTime)!) {
                return appt
            }
        }
        
        return nil
    }
    
    func onAppointmentSelected(appointment: Appointment?) {
        appointmentDetailsView.appointment = appointment
        /*
        if appointment?.url?.absoluteString == AppointmentUtil.APPOINTMENT_URL {
            editButton?.isHidden = false
        } else {
            editButton?.isHidden = true
        }*/
    }
    
    func onRightNav() {
        month += 1
        if month == 13 {
            month = 1
            year += 1
        }
        self.calendarEntry = calendarEntry(month: month, year: year)
        self.currentMonth = monthString(calendarEntry: self.calendarEntry!)
    }
    
    func onLeftNav() {
        month -= 1
        if month == 0 {
            month = 12
            year -= 1
        }
        self.calendarEntry = calendarEntry(month: month, year: year)
        self.currentMonth = monthString(calendarEntry: self.calendarEntry!)
    }
    
    private func calendarEntry(month: Int, year: Int) -> CalendarEntry {
        let calendarEntry =  CalendarUtil.calendarEntryFor(month: month, year: year)
        return calendarEntry
    }
    
    private func monthString(calendarEntry: CalendarEntry) -> String {
        let monthYear = "calendar.month.\(calendarEntry.month - 1)".localized
        return monthYear + " \(calendarEntry.year)"
    }
    
}

extension MonthViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dimen = collectionView.frame.width/(itemsPerRow + 1)
        
        return CGSize(width: dimen, height: dimen)
    }
}
