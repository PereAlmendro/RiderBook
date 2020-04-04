//
//  RideTableViewCell.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class RideTableViewCell: UITableViewCell {
    
    // MARK: - Static constants
    
    static var identifier: String {
        return String(describing: RideTableViewCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier,
                     bundle: Bundle(for: RideTableViewCell.self))
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var circuitLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet weak var bestLapTitleLabel: UILabel!
    @IBOutlet weak var bestLapValueLabel: UILabel!

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        circuitLabel.font = .arialboldMT(size: 17)
        dateLabel.font = .arialMT(size: 17)
        
        bestLapTitleLabel.text = "best_lap".localized()
        bestLapTitleLabel.font = .arialboldMT(size: 17)
        bestLapValueLabel.font = .arialMT(size: 17)
    }
    
    // MARK: - Public functions
    
    func configureWith(circuitName: String, date: String, bestLapTime: String) {
        circuitLabel.text = circuitName
        dateLabel.text = date
        
        bestLapValueLabel.text = bestLapTime.isEmpty ? "-" : bestLapTime
    }
}
