//
//  RBButton.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class RBButton: NibView {
    
    @IBOutlet private weak var button: UIButton!
    
    override func customSetup() {
        button.roundCorners()
        button.backgroundColor = .emeraldGreen
    }
    
    func setTitle(text: String) {
        button.setTitle(text, for: .normal)
    }

}
