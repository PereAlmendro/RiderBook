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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar".localized()
        addRightButtonItem(systemItem: .add)
        setupCalendar()
    }
    
    // MARK: - User Actions
    
    override func rightButtonItemAction(_ sender: Any) {
        presenter.addButtonAction()
    }
    
    // MARK: - Private functions
    
    private func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
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
