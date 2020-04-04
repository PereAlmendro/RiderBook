//
//  CalendarViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: BaseViewController<CalendarPresenter> {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var calendar: FSCalendar!
    private var dataSource: [Ride] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle(presenter.screenTitle)
        addRightButtonItem(systemItem: .add)
        setupView()
        bindToRxProperties()
    }
    
    // MARK: - User Actions
    
    override func rightButtonItemAction(_ sender: Any) {
        presenter.addButtonAction()
    }
    
    // MARK: - Private functions
    
    private func bindToRxProperties() {
        presenter
            .reloadCalendar
            .subscribe { [weak self] event in
                guard event.element == true else { return }
                self?.calendar.reloadData()
        }.disposed(by: disposeBag)
        
        presenter
            .selectedDayRides
            .subscribe { [weak self] event in
                guard let rides = event.element else { return }
                self?.dataSource = rides
                self?.tableView.reloadData()
                self?.tableView.backgroundView?.isHidden = !rides.isEmpty
        }.disposed(by: disposeBag)
    }
    
    private func setupView() {
        setupTableView()
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RideTableViewCell.nib,
                           forCellReuseIdentifier: RideTableViewCell.identifier)
        let emptyView = RBEmptyView()
        emptyView.configureWith(title: "calendar_no_rides".localized(),
                                description: "calendar_tap_to_add_events".localized(),
                                image: UIImage(named: "guest_avatar"))
        tableView.backgroundView = emptyView
    }
}

// MARK: - FSCalendarDelegate

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presenter.didSelectDate(date: date)
    }
}

// MARK: - FSCalendarDataSource

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return presenter.numberOfRides(for: date)
    }
}

// MARK: - UITableViewDelegate

extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRide(ride: dataSource[indexPath.row])
    }
}

// MARK: - UITableViewDataSource

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RideTableViewCell.identifier,
                                                 for: indexPath) as? RideTableViewCell ?? RideTableViewCell()
        let ride = dataSource[indexPath.row]
        cell.configureWith(circuitName: ride.circuit,
                           date: ride.date.toString(style: .short),
                           bestLapTime: ride.bestLapTime)
        return cell
    }
}
