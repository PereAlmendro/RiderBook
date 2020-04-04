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

    @IBOutlet private weak var datePicker: DatePicker!
    @IBOutlet private weak var circuitPicker: CircuitPicker!
    @IBOutlet private weak var saveButton: RBButton!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindToRxProperties()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        datePicker.configureWith(title: "select_date".localized())
        saveButton.setTitle(text: "save".localized())
        saveButton.delegate = self
    }
    
    private func bindToRxProperties() {
        presenter
            .circuitNames
            .subscribe { [weak self] event in
            guard let circuitNames = event.element else { return }
            self?.circuitPicker.configureWith(title: "select_circuit".localized(),
                                              circuits: circuitNames)
        }.disposed(by: disposeBag)
    }
}

extension AddRideViewController: RBButtonDelegate {
    func rbButtonAction(_ sender: RBButton) {
        let selectedDate = datePicker.getSelectedDate()
        let selectedCircuit = circuitPicker.getSelectedCircuit()
        presenter.saveAction(selectedDate: selectedDate, selectedCircuit: selectedCircuit)
    }
}
