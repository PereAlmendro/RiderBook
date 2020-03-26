//
//  CalendarViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class CalendarViewController: BaseViewController<CalendarPresenter> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar".localized()
    }
    
}
