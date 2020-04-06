//
//  RideSummaryView.swift
//  RiderBook
//
//  Created by Pere Almendro on 04/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

protocol RideSummaryViewProtocol: AnyObject{
    func viewRankAction(_ sender: RideSummaryView)
    func rankInfoAction(_ sender: RideSummaryView)
}

class RideSummaryView: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var timeTitleLabel: UILabel!
    @IBOutlet private weak var rankTitleLabel: UILabel!
    
    @IBOutlet private weak var timeValueLabel: UILabel!
    @IBOutlet private weak var rankValueLabel: UILabel!
    
    @IBOutlet private weak var rankInfoButton: UIButton!
    @IBOutlet private weak var viewRankButton: UIButton!
    
    @IBOutlet private weak var rankValueStackView: UIStackView!
    
    // MARK: - Properties
    
    private weak var delegate: RideSummaryViewProtocol?
    
    // MARK: - Lifecycle
    
    override func customSetup() {
        timeTitleLabel.font = UIFont.arialMT(size: 18)
        rankTitleLabel.font = UIFont.arialMT(size: 18)
        
        timeValueLabel.font = UIFont.arialboldMT(size: 20)
        rankValueLabel.font = UIFont.arialboldMT(size: 20)
        
        viewRankButton.setTitle("view_ranking".localized(), for: .normal)
        viewRankButton.setTitleColor(.emeraldGreen, for: .normal)
        
        rankInfoButton.tintColor = .emeraldGreen
        
        timeTitleLabel.text = "best_time".localized()
    }
    
    // MARK: - Public functions
    
    func configureWith(rankingPosition: Int?, bestLapTime: String,
                       delegate: RideSummaryViewProtocol) {
        self.delegate = delegate
        
        timeValueLabel.text = "\(bestLapTime)"
        
        if let rank = rankingPosition {
            rankTitleLabel.text = "rank".localized()
            rankValueLabel.text = "\(rank)"
            rankValueStackView.isHidden = false
            rankInfoButton.isHidden = true
        } else {
            rankTitleLabel.text = "unranked".localized()
            rankValueStackView.isHidden = true
            rankInfoButton.isHidden = false
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func viewRankAction(_ sender: Any) {
        delegate?.viewRankAction(self)
    }
    
    @IBAction private func rankInfoAction(_ sender: Any) {
        delegate?.rankInfoAction(self)
    }
}
