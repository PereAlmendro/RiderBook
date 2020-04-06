//
//  HomeViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

enum HomeRow: Int {
    case profile
    case calendar
}

class HomeViewController: BaseViewController<HomePresenter> {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: [UIView] = []
    private let calendarView = CalendarDashboardView()
    private let profileView = ProfileDashboardView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        dataSource = [
            profileView,
            calendarView
        ]
        
        bindToRxProperties()
    }
    
    // MARK: - Private functions
    
    private func bindToRxProperties() {
        presenter
            .lastRide
            .subscribe { [weak self] event in
                guard
                    let calendarEvent = event.element,
                    let lastCalendarEvent = calendarEvent else { return }
                
                self?.calendarView.configureWith(title: lastCalendarEvent.circuit.name,
                                                 description: lastCalendarEvent.date.toString(style: .short))
                
                self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    private func setupView() {
        setScreenTitle(presenter.screenTitle)
        addBackgroundImage()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.nib,
                           forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row: HomeRow = HomeRow(rawValue: indexPath.row) else { return }
        switch row {
        case .profile:
            presenter.tapOnProfile()
        case .calendar:
            presenter.tapOnCalendar()
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                 for: indexPath) as? HomeTableViewCell ?? HomeTableViewCell()
        let view = dataSource[indexPath.row]
        cell.configureCell(with: view)
        return cell
    }
}
