//
//  AlertView.swift
//  RiderBook
//
//  Created by Pere Almendro on 28/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

enum AlertType {
    case error
    case info
    case success
}

class AlertView: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var viewHolder: UIView!
    @IBOutlet private weak var alertImageView: UIImageView!
    @IBOutlet private weak var alertTitleLabel: UILabel!
    @IBOutlet private weak var alertMessageLabel: UILabel!
    
    // MARK: - Properties
    
    private var completion: (() -> ())?
    
    // MARK: - Lifecycle
    
    override func customSetup() {
        alertTitleLabel.font = .arialboldMT(size: 17)
        alertMessageLabel.font = .arialMT(size: 15)
        alertMessageLabel.textColor = .customGray
        backgroundView.alpha = 0.85
        viewHolder.roundCorners(radius: 5)
        shadowView.addShadow()
    }
    
    // MARK: - Public functions
    
    func configureWith(type: AlertType, title: String?, message: String?, completion: (() -> ())?) {
        alertTitleLabel.text = title
        alertMessageLabel.text = message
        alertImageView.image = getImageFor(type: type)
        
        self.completion = completion
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Private functions
    
    private func getImageFor(type: AlertType) -> UIImage?  {
        let image: UIImage?
        switch type {
        case .info:
            image = UIImage(named: "blue_flag")?.withRenderingMode(.alwaysOriginal)
        case .error:
            image = UIImage(named: "red_flag")?.withRenderingMode(.alwaysOriginal)
        case .success:
            image = UIImage(named: "green_flag")?.withRenderingMode(.alwaysOriginal)
        }
        return image
    }
    
    @objc private func dismissAlert() {
        completion?()
        removeFromSuperview()
    }
    
    // MARK: - IBActions
    
    @IBAction private func closeButtonAction(_ sender: Any) {
        dismissAlert()
    }
}
