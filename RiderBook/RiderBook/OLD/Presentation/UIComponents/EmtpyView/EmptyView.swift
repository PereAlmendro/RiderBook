//
//  EmptyView.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class EmptyView: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func customSetup() {
        titleLabel.font = .arialboldMT(size: 17)
        descriptionLabel.font = .arialMT(size: 15)
        descriptionLabel.textColor = .customGray
        emptyImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Public functions
    
    func configureWith(title: String, description: String, image: UIImage? = nil) {
        emptyImageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
