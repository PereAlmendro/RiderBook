//
//  ProfileDashboardView.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class ProfileDashboardView: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var rightImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle

    override func customSetup() {
        setupLabels()
        
        // Default
        configureWith(title: "Guest Rider".localized(),
                      image: UIImage(named: "guest_avatar")?.withRenderingMode(.alwaysOriginal),
                      description: "Log in to use all features, its free!".localized())
    }
    
    // MARK: - Public
    
    func configureWith(title: String, image: UIImage?, description: String) {
        rightImage.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    // MARK: - Private
    
    func setupLabels() {
        titleLabel.font = .arialboldMT(size: 17)
        titleLabel.textColor = .black
        
        descriptionLabel.font = .arialMT(size: 14)
        descriptionLabel.textColor = .customGray
    }
}
