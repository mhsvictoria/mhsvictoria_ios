//
//  MonthsCollectionView.swift
//  See Me Soon
//
//  Created by Ron Allan on 2019-01-12.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

class MonthsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let years = [2019, 2020, 2021]

    let monthReuseIdentifier = "monthCell"
    var calendarEntryDelegate: CalendarEntryDelegate?
    var headerView: UIView?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        register(MonthViewCell.self, forCellWithReuseIdentifier: monthReuseIdentifier)
        /*
        register(UINib(nibName: HeaderReusableView.nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
         */
        delegate = self
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 12
        case 1:
            return 4
        default:
            return 6
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthReuseIdentifier, for: indexPath) as! MonthViewCell
        cell.layer.borderWidth = 1
        cell.title.text = months[indexPath.row] + " \(years[indexPath.section])"
        
        switch indexPath.section {
        case 0:
            cell.layer.borderColor = UIColor.blue.cgColor
        case 1:
            cell.layer.borderColor = UIColor.red.cgColor
        default:
            cell.layer.borderColor = UIColor.green.cgColor
        }
        let onTapRecognizer = TapGestureRecognizer(target: self, action: #selector(onMonthSelected(_:)))
        onTapRecognizer.name = cell.title.text
        onTapRecognizer.properties!["month"] = (indexPath.row % 12)
        onTapRecognizer.properties!["year"] = years[indexPath.section]
        cell.addGestureRecognizer(onTapRecognizer)
        return cell
    }

    @objc func onMonthSelected(_ sender: TapGestureRecognizer) {
        
        let month = (sender.properties!["month"] as! Int) + 1
        let year = sender.properties!["year"] as! Int
        //NSLog("Month tapped \(month) - year: \(year)")
        let calendarEntry = CalendarUtil.calendarEntryFor(month: month, year: year)
        calendarEntryDelegate?.onCalendarEntrySelected(calendarEntry)
    }
}

class TapGestureRecognizer: UITapGestureRecognizer {

    var properties: [String: Any?]?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        properties = [String: Any?]()
    }
}
