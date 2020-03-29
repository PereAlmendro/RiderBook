//
//  MyRidesViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class MyRidesViewController: BaseViewController<MyRidesPresenter> {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My rides"
        enableLargeTitles(true)
    }

}
