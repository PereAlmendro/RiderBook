//
//  RideTableViewCell.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class RideTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var circuitLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Static constants
    
    static var identifier: String {
        return String(describing: RideTableViewCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier,
                     bundle: Bundle(for: RideTableViewCell.self))
    }

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circuitLabel.font = .arialboldMT(size: 17)
        dateLabel.font = .arialMT(size: 17)
    }
    
    // MARK: - Public
    
    func configureWith(circuitName: String, date: String) {
        circuitLabel.text = circuitName
        dateLabel.text = date
    }
}
