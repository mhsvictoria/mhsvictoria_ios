//
//  MonthViewController.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-13.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

class MonthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AppointmentDelegate {
    
    let NUM_DAYS = 7
    let NUM_WEEKS = 6
    let reuseIdentifier = "dayCollectionViewCell"
    
    @IBOutlet weak var daysCollectionView: DaysCollectionView!
    
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
        }
    }
    
    var monthLabel: UILabel?
    var currentMonth: String? {
        didSet {
            if monthLabel == nil {
                monthLabel = UILabel(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 40))
                monthLabel?.textColor = UIColor.darkGray
                monthLabel?.font = UIFont(name: fontName, size: fontSizeHuge)
                monthLabel?.textAlignment = .center
                self.view.addSubview(monthLabel!)
            }
            monthLabel?.text = currentMonth
        }
    }
    var calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysCollectionView.dataSource = self
        daysCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        daysCollectionView.reloadData()
        currentSelected = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let _ = monthArr else {
            return 0
        }
        
        let appointmentManager = AppointmentManager(appointmentDelegate: self)
        
        appointmentsLastMonth = appointmentManager.retrieveAllAppointmentsFor(month: (calendarEntry?.lastMonth)!, day: 1, year: (calendarEntry?.lastMonthYear)!, daysAhead: (calendarEntry?.numberOfDaysLastMonth)!, filteredOn: nil)
        
        appointmentsThisMonth = appointmentManager.retrieveAllAppointmentsFor(month: (calendarEntry?.month)!, day: 1, year: (calendarEntry?.year)!, daysAhead: (calendarEntry?.numberOfDaysThisMonth)!, filteredOn: nil)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
        
        let dimen = collectionView.frame.width/itemsPerRow
        
        return CGSize(width: dimen, height: dimen)
    }
}
