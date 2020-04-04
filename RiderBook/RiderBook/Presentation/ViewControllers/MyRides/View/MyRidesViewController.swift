//
//  MyRidesViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import RxSwift

class MyRidesViewController: BaseViewController<MyRidesPresenter> {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        setScreenTitle(presenter.screenTitle)
        enableLargeTitles(true)
        setupTableView()
        bindToRxProperties()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RideTableViewCell.nib,
                           forCellReuseIdentifier: RideTableViewCell.identifier)
    }
    
    private func bindToRxProperties() {
        presenter.reloadTable.subscribe({ [weak self] event in
            guard event.element == true else { return }
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

}

// MARK: - UITableViewDelegate

extension MyRidesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension MyRidesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RideTableViewCell.identifier,
                                                 for: indexPath) as? RideTableViewCell ?? RideTableViewCell()
        
        let ride = presenter.ride(indexPath: indexPath)
        cell.configureWith(circuitName: ride.circuit,
                           date: ride.date.toString(style: .short),
                           bestLapTime: ride.bestLapTime)
        
        return cell
    }
}

