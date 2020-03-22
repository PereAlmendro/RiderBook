//
//  RBButton.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

protocol RBButtonDelegate {
    func rbButtonAction(_ sender: RBButton)
}

class RBButton: NibView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var button: UIButton!
    
    // MARK: - Delegate
    
    var delegate: RBButtonDelegate?
    
    // MARK: - Private
    
    override func customSetup() {
        button.roundCorners()
        button.backgroundColor = .emeraldGreen
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.rbButtonAction(self)
    }
    
    // MARK: - Public
    
    func setTitle(text: String) {
        button.setTitle(text, for: .normal)
    }

}
