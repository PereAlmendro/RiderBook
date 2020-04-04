//
//  LapTableViewCell.swift
//  RiderBook
//
//  Created by Pere Almendro on 04/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class LapTableViewCell: UITableViewCell {
    
    // MARK: - Static constants
    
    static var identifier: String {
        return String(describing: LapTableViewCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier,
                     bundle: Bundle(for: LapTableViewCell.self))
    }
    
    // MARK: - IBOutlets

    @IBOutlet weak var lapNameLabel: UILabel!
    @IBOutlet weak var lapTimeLabel: UILabel!
    
    // MARK: - lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lapNameLabel.font = UIFont.arialboldMT(size: 18)
        lapTimeLabel.font = UIFont.arialboldMT(size: 18)
    }
    
    // MARK: - Public func
    
    func configureWith(lap: Lap) {
        lapNameLabel.text = lap.name
        lapTimeLabel.text = lap.time
    }
}
