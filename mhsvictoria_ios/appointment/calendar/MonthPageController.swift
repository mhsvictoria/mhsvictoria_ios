//
//  MonthPageController.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-13.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

class MonthPageController: UIPageViewController {

    var month: Int = CalendarUtil.calendarEntryForToday().month
    var year: Int = CalendarUtil.calendarEntryForToday().year
    
    var initialCalendarEntry: CalendarEntry? {
        didSet {
            month = (initialCalendarEntry?.month)!
            year = (initialCalendarEntry?.year)!
        }
    }

    private(set) lazy var orderedViewControllers: [MonthViewController] = {
        return [self.newMonthViewController(),
                self.newMonthViewController(),
                self.newMonthViewController()
                ]
    }()
    
    private func newMonthViewController() -> MonthViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "monthViewController") as! MonthViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            firstViewController.calendarEntry = calendarEntry(month: month, year: year)
            firstViewController.currentMonth = monthString(calendarEntry: (firstViewController.calendarEntry)!)
        }
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
// MARK: UIPageViewControllerDataSource
extension MonthPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! MonthViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        month -= 1
        if month == 0 {
            month = 12
            year -= 1
        }
        //NSLog("viewControllerIndex: \(viewControllerIndex) - PreviousIndex: \(previousIndex) - month: \(month) - year: \(year)")
        
        
        guard previousIndex >= 0 else {
            let vc = orderedViewControllers.last
            vc?.calendarEntry = calendarEntry(month: month, year: year)
            vc?.currentMonth = monthString(calendarEntry: (vc?.calendarEntry)!)
            return vc
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        
        let vc = orderedViewControllers[previousIndex]
        vc.calendarEntry = calendarEntry(month: month, year: year)
        vc.currentMonth = monthString(calendarEntry: (vc.calendarEntry)!)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! MonthViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        month += 1
        if month == 13 {
            month = 1
            year += 1
        }
        
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            let vc = orderedViewControllers.first
            vc?.calendarEntry = calendarEntry(month: month, year: year)
            vc?.currentMonth = monthString(calendarEntry: (vc?.calendarEntry)!)
            return vc
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        let vc = orderedViewControllers[nextIndex]
        vc.calendarEntry = calendarEntry(month: month, year: year)
        vc.currentMonth = monthString(calendarEntry: (vc.calendarEntry)!)
        return vc
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
