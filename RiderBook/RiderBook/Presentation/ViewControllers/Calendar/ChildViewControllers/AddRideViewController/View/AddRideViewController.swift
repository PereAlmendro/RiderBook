//
//  AddRideViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class AddRideViewController: BaseViewController<AddRidePresenter> {

    // MARK: - IBOutlets

    @IBOutlet private weak var datePicker: RBDatePicker!
    @IBOutlet private weak var circuitPicker: RBCircuitPicker!
    @IBOutlet private weak var saveButton: RBButton!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.configureWith(title: "select_date".localized())
        circuitPicker.configureWith(title: "select_circuit".localized(),
                                    circuits: presenter.getCircuitNames())
        saveButton.setTitle(text: "save".localized())
        saveButton.delegate = self
    }
}

extension AddRideViewController: RBButtonDelegate {
    func rbButtonAction(_ sender: RBButton) {
        presenter.saveAction()
    }
}
