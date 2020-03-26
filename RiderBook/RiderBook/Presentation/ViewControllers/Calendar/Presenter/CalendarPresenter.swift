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
    
    private let calendarRouter: CalendarRouter
    
    init(calendarRouter: CalendarRouter) {
        self.calendarRouter = calendarRouter
    }
    
    // MARK: - User Actions
    
    func addButtonAction() {
        calendarRouter.showAddRide()
    }
}
