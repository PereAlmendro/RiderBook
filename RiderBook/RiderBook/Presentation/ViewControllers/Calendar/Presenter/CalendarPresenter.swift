//
//  CalendarPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class CalendarPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let calendarRouter: CalendarRouter
    private let calendarInteractor: CalendarInteractor
    
    // MARK: - Lifecycle
    
    init(calendarRouter: CalendarRouter, calendarInteractor: CalendarInteractor) {
        self.calendarRouter = calendarRouter
        self.calendarInteractor = calendarInteractor
    }
    
    // MARK: - Public functions
    
    func numberOfEvents(for date: Date) -> Int {
        // TODO
        return .zero
    }
    
    func hasEvents() -> Bool {
        // TODO
        return false
    }
    
    // MARK: - User Actions
    
    func addButtonAction() {
        calendarRouter.showAddRide()
    }
    
    func didSelectDate(date: Date) {
        // TODO: Do something when user selects date.
    }
}
