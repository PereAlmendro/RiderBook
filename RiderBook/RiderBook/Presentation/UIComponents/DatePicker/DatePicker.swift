//
//  DatePicker.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class DatePicker: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    // MARK: - Lifecycle
    
    override func customSetup() {
        titleLabel.font = .arialboldMT(size: 23)
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
    }
    
    // MARK: - Public functions
    
    func configureWith(title: String) {
        titleLabel.text = title
    }
    
    func getSelectedDate() -> Date {
        return datePicker.date
    }
}
