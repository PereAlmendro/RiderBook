//
//  RideDetailViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class RideDetailViewController: BaseViewController<RideDetailPresenter> {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var rideSummaryView: RideSummaryView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    
    private func setupView()  {
        titleLabel.text = presenter.ride?.circuit.name
        subtitleLabel.text = presenter.ride?.date.toString(style: .short)
        addBackButton()
        enableLargeTitles(false)
    }

}
