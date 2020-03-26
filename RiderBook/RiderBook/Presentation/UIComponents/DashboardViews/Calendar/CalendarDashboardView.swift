//
//  CalendarDashboardView.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class CalendarDashboardView: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func customSetup() {
        setupLabels()
        alpha = 0.90
        
        // Default
        configureWith(title: "🏜".localized(),
                      description: "calendar_no_rides".localized())
    }
    
    // MARK: - Public
    
    func configureWith(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    // MARK: - Private
    
    func setupLabels() {
        titleLabel.font = .arialboldMT(size: 35)
        titleLabel.textColor = .black
        
        descriptionLabel.font = .arialMT(size: 14)
        descriptionLabel.textColor = .customGray
    }
}
