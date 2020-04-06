//
//  LapTableViewCell.swift
//  RiderBook
//
//  Created by Pere Almendro on 04/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

protocol LapTableViewCellDelegate {
    func editButtonAction(for lap: Lap)
    func deleteButtonAction(for lap: Lap)
}

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

    @IBOutlet private weak var lapNameLabel: UILabel!
    @IBOutlet private weak var lapTimeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    
    private var lap: Lap?
    private var delegate: LapTableViewCellDelegate?
    
    // MARK: - lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lapNameLabel.font = UIFont.arialboldMT(size: 18)
        lapTimeLabel.font = UIFont.arialboldMT(size: 18)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Public functions
    
    func configureWith(lap: Lap, delegate: LapTableViewCellDelegate? = nil) {
        self.delegate = delegate
        self.lap = lap
        lapNameLabel.text = "\(lap.number)"
        lapTimeLabel.text = lap.time
    }
    
    // MARK: - IBActions
    
    @IBAction func editButtonAction(_ sender: Any) {
        guard let lap = lap else { return }
        delegate?.editButtonAction(for: lap)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        guard let lap = lap else { return }
        delegate?.deleteButtonAction(for: lap)
    }
}
