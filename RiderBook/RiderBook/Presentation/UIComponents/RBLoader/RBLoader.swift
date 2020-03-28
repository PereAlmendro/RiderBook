//
//  RBLoader.swift
//  RiderBook
//
//  Created by Pere Almendro on 28/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class RBLoader: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    
    override func customSetup() {
        activityIndicator.color = .emeraldGreen
        activityIndicator.startAnimating()
    }
}
