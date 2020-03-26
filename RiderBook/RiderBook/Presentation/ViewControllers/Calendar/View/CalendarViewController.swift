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
    
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var emptyView: RBEmptyView!

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar".localized()
        addRightButtonItem(systemItem: .add)
        setupView()
    }
    
    // MARK: - User Actions
    
    override func rightButtonItemAction(_ sender: Any) {
        presenter.addButtonAction()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        calendar.delegate = self
        calendar.dataSource = self
        if !presenter.hasEvents() {
            emptyView.configureWith(title: "calendar_no_rides".localized(),
                                    description: "calendar_tap_to_add_events".localized(),
                                    image: UIImage(named: "guest_avatar"))
        }
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
        return presenter.numberOfEvents(for: date)
    }
}
