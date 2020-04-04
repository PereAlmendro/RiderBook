//
//  RideDetailViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class RideDetailViewController: BaseViewController<RideDetailPresenter> {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    
    private func setupView()  {
        addBackButton()
        enableLargeTitles(true)
    }

}
