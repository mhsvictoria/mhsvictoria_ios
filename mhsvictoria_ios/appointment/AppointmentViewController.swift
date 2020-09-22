//
//  ManageViewController.swift
//  pika
//
//  Created by Ron Allan on 2019-02-16.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

class AppointmentViewController: UIViewController {
    
    var appointmentDelegate: AppointmentDelegate?
    var appointmentId: String?
    
    var appointmentManager: AppointmentManager?
    var appointmentFormView: AppointmentFormView?
    /*
    override func initActionbar() {
        super.initActionbar()
        actionbarView.actionbarDelegate = self
        if appointmentFormView?.appointment != nil {
            manageButtonState(.updating)
        } else {
            manageButtonState(.clear)
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentFormView = AppointmentFormView()
        self.view.addSubview(appointmentFormView!)
        
        appointmentManager = AppointmentManager(appointmentDelegate: self)
        
        if let _ = AppointmentManager.selected {
            appointmentFormView?.appointment = AppointmentManager.selected
        }
        
        appointmentFormView?.titleField?.addTarget(self, action: #selector(titleFieldDidChange), for: .editingChanged)
        
        appointmentFormView?.descriptionField?.addTarget(self, action: #selector(descriptionFieldDidChange), for: .editingChanged)
        
        //initActionbar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        appointmentFormView?.translatesAutoresizingMaskIntoConstraints = false
        
        appointmentFormView?.widthAnchor.constraint(equalToConstant: self.view.frame.width - margin).isActive = true
        appointmentFormView?.heightAnchor.constraint(equalToConstant: 3 * self.view.frame.height/4).isActive = true
        appointmentFormView?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        appointmentFormView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = UIColor.clear
        
        appointmentFormView?.backgroundColor = UIColor.clear
        self.view.bringSubviewToFront(appointmentFormView!)
        
    }
    
    @objc func titleFieldDidChange(_ sender: UITextField) {
        /*
        if (sender.text?.count)! > 0  || (appointmentFormView?.descriptionField?.text?.count)! > 0{
            manageButtonState(.creating)
        } else {
            manageButtonState(.clear)
        }*/
    }
    
    @objc func descriptionFieldDidChange(_ sender: UITextField) {
        /*
        if (sender.text?.count)! > 0 || (appointmentFormView?.titleField?.text?.count)! > 0 {
            manageButtonState(.creating)
        } else {
            manageButtonState(.clear)
        }*/
    }
    /*
    func onAction(_ action: SelectedAction, message: String?) {
        switch(action) {
        case .clear:
            clear()
            break
        case .create:
            create()
            break
        case .delete:
            delete()
            break
        case .update:
            update()
            break
        }
    }
    */
    private func clear() {
        appointmentFormView?.titleField.text = ""
        appointmentFormView?.descriptionField.text = ""
        //manageButtonState(.clear)
    }
    
    private func create() {
        let appointment = Appointment((appointmentFormView?.titleField?.text)!, startTime: (appointmentFormView?.dateFrom.date)!, endTime: (appointmentFormView?.dateTo.date)!, timeZone: TimeZone.current)
        appointment.notes = appointmentFormView?.descriptionField?.text
        onAppointmentAction(appointment: appointment, action: .make)
        
        // reset
        appointmentFormView?.fromToSelect?.selectedSegmentIndex = 0
        appointmentFormView?.dateTo?.isHidden = true
        appointmentFormView?.dateFrom?.isHidden = false
        clear()
    }
    
    private func delete() {
        let appointment = appointmentFormView?.appointment
        onAppointmentAction(appointment: appointment!, action: .cancel)
        clear()
    }
    
    private func update() {
        let appointment = Appointment((appointmentFormView?.titleField?.text)!, startTime: (appointmentFormView?.dateFrom.date)!, endTime: (appointmentFormView?.dateTo.date)!, timeZone: TimeZone.current)
        appointment.notes = appointmentFormView?.descriptionField?.text
        onAppointmentAction(appointment: appointment, action: .make)
        appointment.identifier = appointmentId
        onAppointmentAction(appointment: appointment, action: .update)
        // reset
        appointmentFormView?.fromToSelect?.selectedSegmentIndex = 0
        appointmentFormView?.dateTo?.isHidden = true
        appointmentFormView?.dateFrom?.isHidden = false
        clear()
    }
}

extension AppointmentViewController: AppointmentDelegate {
    func onAppointmentAction(appointment: Appointment, action: AppointmentAction) {
        
        appointmentManager?.daysAhead = 0//appointmentManager?.current
        
        switch(action) {
        case .make:
            appointmentManager?.make(appointment: appointment)
            break
        case .read:
            appointmentManager?.read(appointmentId: appointment.identifier)
            break
        case .update:
            appointmentManager?.update(appointment: appointment)
            break
        case .cancel:
            appointmentManager?.cancel(appointment: appointment)
            break
        case .completed:
            DispatchQueue.main.async {
                self.appointmentFormView?.setNeedsLayout()
            }
            break
        case .select:
            appointmentFormView?.appointment = appointment
            //manageButtonState(.updating)
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
        case .completed:
            break
        case .select:
            break
        }
        
        DispatchQueue.main.async {
            self.appointmentFormView?.setNeedsLayout()
        }
    }
    
    private func displayAlertMessage(errorMsg: String?, error: Error?) {
        
    }
}
