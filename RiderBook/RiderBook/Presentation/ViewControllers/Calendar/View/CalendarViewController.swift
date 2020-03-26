//
//  CalendarViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class CalendarViewController: BaseViewController<CalendarPresenter> {
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar".localized()
        addRightButtonItem(systemItem: .add)
    }
    
    // MARK: - User Actions
    
    override func rightButtonItemAction(_ sender: Any) {
        presenter.addButtonAction()
    }
}
