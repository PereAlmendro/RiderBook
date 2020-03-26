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
    
    // MARK: - Lifecycle
    
    init(calendarRouter: CalendarRouter) {
        self.calendarRouter = calendarRouter
    }
    
    // MARK: - Public functions
    
    func numberOfEvents(for date: Date) -> Int {
        // TODO: Return the number of events for each date
        return .zero
    }
    
    // MARK: - User Actions
    
    func addButtonAction() {
        calendarRouter.showAddRide()
    }
    
    func didSelectDate(date: Date) {
        // TODO: Do something when user selects date.
    }
}
