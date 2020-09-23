//
//  ManageViewController.swift
//  pika
//
//  Created by Ron Allan on 2019-02-16.
//  Copyright © 2019 RCAL Software Solutions. All rights reserved.
//

import UIKit
import AppointmentKit

class AppointmentViewController: UIViewController, ActionbarDelegate {

    var appointmentDelegate: AppointmentDelegate?
    var appointmentId: String?
    
    var appointmentManager: AppointmentManager?
    
    @IBOutlet weak var appointmentFormView: AppointmentFormView!
    
    enum ButtonState {
        case clear, creating, updating, initial
    }
    
    var currentButtonState: ButtonState = .clear
    @IBOutlet weak var actionbarView: ActionbarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentManager = AppointmentManager(appointmentDelegate: self)
        
        if let _ = AppointmentManager.selected {
            appointmentFormView.appointment = AppointmentManager.selected
        }
        
        appointmentFormView.titleField.addTarget(self, action: #selector(titleFieldDidChange), for: .editingChanged)
        
        appointmentFormView.descriptionField.addTarget(self, action: #selector(descriptionFieldDidChange), for: .editingChanged)
        
        initActionbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        actionbarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actionbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            actionbarView.heightAnchor.constraint(equalToConstant: controlBarHeight)
        ])
        
        appointmentFormView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appointmentFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            appointmentFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            appointmentFormView.bottomAnchor.constraint(equalTo: actionbarView.topAnchor, constant: -margin),
            appointmentFormView.topAnchor.constraint(equalTo: view.topAnchor, constant: marginLrg)
        ])
    }
    
    
    private func initActionbar() {
        actionbarView.actionbarDelegate = self
        if appointmentFormView.appointment != nil {
            manageButtonState(.updating)
        } else {
            manageButtonState(.clear)
        }
        
        actionbarView.backgroundColor = toolbarColor
        
    }
    
    @objc func titleFieldDidChange(_ sender: UITextField) {
        
        if (sender.text?.count)! > 0  || (appointmentFormView.descriptionField.text?.count)! > 0{
            manageButtonState(.creating)
        } else {
            manageButtonState(.clear)
        }
    }
    
    @objc func descriptionFieldDidChange(_ sender: UITextField) {
        
        if (sender.text?.count)! > 0 || (appointmentFormView.titleField.text?.count)! > 0 {
            manageButtonState(.creating)
        } else {
            manageButtonState(.clear)
        }
    }
    
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
    
    func manageButtonState(_ state: ButtonState) {
        
        switch(state) {
        case .creating:
            actionbarView.createButton.setTitle(actionbarView.createText, for: .normal)
            actionbarView.clearButton.isEnabled = true
            actionbarView.createButton.isEnabled = true
            actionbarView.deleteButton.isEnabled = false
            break
        case .updating:
            actionbarView?.createButton.setTitle(actionbarView.updateText, for: .normal)
            actionbarView.clearButton.isEnabled = true
            actionbarView.createButton.isEnabled = true
            actionbarView.deleteButton.isEnabled = true
            break
        case .clear:
            actionbarView.createButton.setTitle(actionbarView.createText, for: .normal)
            actionbarView.clearButton.isEnabled = false
            actionbarView.createButton.isEnabled = false
            actionbarView.deleteButton.isEnabled = false
            break
        case .initial:
            actionbarView.createButton.setTitle(actionbarView.createText, for: .normal)
            actionbarView.clearButton.isEnabled = true
            actionbarView.createButton.isEnabled = false
            actionbarView.deleteButton.isEnabled = false
            break
        }
        currentButtonState = state
    }
    
    private func clear() {
        appointmentFormView.titleField.text = ""
        appointmentFormView.descriptionField.text = ""
        manageButtonState(.clear)
    }
    
    private func create() {
        let appointment = Appointment((appointmentFormView.titleField.text)!, startTime: (appointmentFormView.dateFrom.date), endTime: (appointmentFormView.dateTo.date), timeZone: TimeZone.current)
        appointment.notes = appointmentFormView.descriptionField.text
        onAppointmentAction(appointment: appointment, action: .make)
        
        // reset
        appointmentFormView.fromToSelect.selectedSegmentIndex = 0
        appointmentFormView.dateTo.isHidden = true
        appointmentFormView.dateFrom.isHidden = false
        clear()
    }
    
    private func delete() {
        let appointment = appointmentFormView.appointment
        onAppointmentAction(appointment: appointment!, action: .cancel)
        clear()
    }
    
    private func update() {
        let appointment = Appointment((appointmentFormView.titleField.text)!, startTime: (appointmentFormView.dateFrom.date), endTime: (appointmentFormView.dateTo.date), timeZone: TimeZone.current)
        appointment.notes = appointmentFormView.descriptionField.text
        onAppointmentAction(appointment: appointment, action: .make)
        appointment.identifier = appointmentId
        onAppointmentAction(appointment: appointment, action: .update)
        // reset
        appointmentFormView.fromToSelect.selectedSegmentIndex = 0
        appointmentFormView.dateTo.isHidden = true
        appointmentFormView.dateFrom.isHidden = false
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
                self.appointmentFormView.setNeedsLayout()
            }
            break
        case .select:
            appointmentFormView.appointment = appointment
            manageButtonState(.updating)
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
            self.appointmentFormView.setNeedsLayout()
        }
    }
    
    private func displayAlertMessage(errorMsg: String?, error: Error?) {
        
    }
}
