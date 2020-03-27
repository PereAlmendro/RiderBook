//
//  RBCircuitPicker.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

protocol RBCircuitPickerDelegate: AnyObject {
    func didSelectCircuit(at index: Int, sender: RBCircuitPicker)
}

class RBCircuitPicker: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var circuitPicker: UIPickerView!
    
    // MARK: - Properties

    private var dataSource: [String] = []
    private weak var delegate: RBCircuitPickerDelegate?
    
    // MARK: - Lifecycle

    override func customSetup() {
        titleLabel.font = .arialboldMT(size: 25)
        circuitPicker.dataSource = self
        circuitPicker.delegate = self
    }
    
    // MARK: - Public functions
    
    func configureWith(title: String, circuits: [String], delegate: RBCircuitPickerDelegate? = nil) {
        self.delegate = delegate
        titleLabel.text = title
        dataSource = circuits
        circuitPicker.reloadAllComponents()
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
        delegate?.didSelectCircuit(at: row, sender: self)
    }
}
