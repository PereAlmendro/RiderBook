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
        addBackButton()
        enableLargeTitles(false)
        
        titleLabel.text = presenter.ride?.circuit.name
        subtitleLabel.text = presenter.ride?.date.toString(style: .short)
        
        if let ride = presenter.ride {
            rideSummaryView.configureWith(rankingPosition: nil,
                                          bestLapTime: ride.bestLap?.time ?? "",
                                          delegate: self)
        }

        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LapTableViewCell.nib,
                           forCellReuseIdentifier: LapTableViewCell.identifier)
        tableView.reloadData()
    }
}

// MARK: - RideSummaryViewProtocol

extension RideDetailViewController: RideSummaryViewProtocol {
    func rankButtonAction(_ sender: RideSummaryView, action: RankButtonAction) {
        switch action {
        case .showInfoRank:
            presenter.showRankInfo()
        case .viewRank:
            presenter.showRank()
        }
    }
}

// MARK: - UITableViewDelegate

extension RideDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource

extension RideDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.ride?.laps.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let lap = presenter.ride?.laps[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: LapTableViewCell.identifier,
                                                     for: indexPath) as? LapTableViewCell else {
                                                        return LapTableViewCell()
        }
        cell.configureWith(lap: lap, delegate: self)
        return cell
    }
}

// MARK: - LapTableViewCellDelegate

extension RideDetailViewController: LapTableViewCellDelegate {
    func editButtonAction(for lap: Lap) {
        presenter.didPressEdit(for: lap)
    }
    
    func deleteButtonAction(for lap: Lap) {
        presenter.didPressDelete(for: lap)
    }
}
