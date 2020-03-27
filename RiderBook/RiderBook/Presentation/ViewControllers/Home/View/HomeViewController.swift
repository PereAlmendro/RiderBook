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
    private var dataSource: [HomeCellViewModel] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let profileRow = HomeCellViewModel(view: ProfileDashboardView(), row: .profile)
        dataSource.append(profileRow)
        
        bindToRxProperties()
    }
    
    // MARK: - Private methods
    
    private func bindToRxProperties() {
        presenter
            .lasCalendarEvent
            .subscribe { [weak self] event in
                guard let calendarEvent = event.element else { return }
                
                if let lastCalendarEvent = calendarEvent {
                    let calendarView = CalendarDashboardView()
                    calendarView.configureWith(title: lastCalendarEvent.circuit,
                                               description: lastCalendarEvent.date.toString(style: .short))
                    let calendarRow = HomeCellViewModel(view: calendarView, row: .calendar)
                    self?.dataSource.append(calendarRow)
                    self?.tableView.reloadData()
                }
        }.disposed(by: disposeBag)
    }
    
    private func setupView() {
        navigationItem.title = "Rider_book".localized()
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
        
        let cellViewModel = dataSource[indexPath.row]
        cell.configureCell(with: cellViewModel)
        
        return cell
    }
}
