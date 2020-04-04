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
    func rankButtonAction(_ sender: RideSummaryView, action: RankButtonAction)
}

enum RankButtonAction {
    case viewRank
    case showInfoRank
}

class RideSummaryView: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var firstLabelTitle: UILabel!
    @IBOutlet private weak var middleLabelTitle: UILabel!
    
    @IBOutlet private weak var firstLabelValue: UILabel!
    @IBOutlet private weak var middleLabelValue: UILabel!
    
    @IBOutlet private weak var rankingButton: UIButton!
    
    // MARK: - Properties
    
    private weak var delegate: RideSummaryViewProtocol?
    private var rankAction: RankButtonAction = .viewRank
    
    // MARK: - Lifecycle
    
    override func customSetup() {
        firstLabelTitle.font = UIFont.arialMT(size: 18)
        middleLabelTitle.font = UIFont.arialMT(size: 18)
        
        firstLabelValue.font = UIFont.arialboldMT(size: 20)
        middleLabelValue.font = UIFont.arialboldMT(size: 20)
    }
    
    // MARK: - Public functions
    
    func configureWith(rankingPosition: Int?, bestLapTime: String,
                       delegate: RideSummaryViewProtocol) {
        self.delegate = delegate
        
        firstLabelTitle.text = "best_time".localized() + " :"
        firstLabelValue.text = "\(bestLapTime)"
        
        if let rank = rankingPosition {
            middleLabelTitle.text = "rank".localized() + ":"
            middleLabelValue.text = "\(rank)".localized()
            rankingButton.setTitle("view_ranking".localized(), for: .normal)
            rankAction = .viewRank
        } else {
            middleLabelTitle.text = "unranked".localized()
            middleLabelValue.text = nil
            rankingButton.setTitle("more_information".localized(), for: .normal)
            rankAction = .showInfoRank
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func rankingButtonAction(_ sender: Any) {
        delegate?.rankButtonAction(self, action: rankAction)
    }
}
