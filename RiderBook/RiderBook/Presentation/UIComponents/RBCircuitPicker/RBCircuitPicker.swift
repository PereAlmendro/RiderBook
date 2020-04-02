//
//  RBCircuitPicker.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class RBCircuitPicker: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var circuitPicker: UIPickerView!
    
    // MARK: - Properties

    private var dataSource: [String] = []
    private var selectedCircuit: String = ""
    
    // MARK: - Lifecycle

    override func customSetup() {
        titleLabel.font = .arialboldMT(size: 23)
        circuitPicker.dataSource = self
        circuitPicker.delegate = self
    }
    
    // MARK: - Public functions
    
    func configureWith(title: String, circuits: [String]) {
        titleLabel.text = title
        dataSource = circuits
        selectedCircuit = circuits.first ?? ""
        circuitPicker.reloadAllComponents()
    }
    
    func getSelectedCircuit() -> String {
        return selectedCircuit
    }
}

// MARK: - UIPickerViewDataSource

extension RBCircuitPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
}

// MARK: - UIPickerViewDelegate

extension RBCircuitPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCircuit = dataSource[row]
    }
}
