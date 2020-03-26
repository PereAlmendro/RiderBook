//
//  homePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

enum HomeRow {
    case profile
    case calendar
}

class HomePresenter: BasePresenter {
    
    private let homeRouter: HomeRouter
    var dataSource: [HomeCellViewModel] = []
    
    init(homeRouter: HomeRouter) {
        self.homeRouter = homeRouter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeDashboardViews()
    }
    
    // MARK: - User Actions
    
    func didSelectRow(at indexPath: IndexPath) {
        let row = dataSource[indexPath.row].row
        switch row {
        case .profile:
            homeRouter.showProfile()
        case .calendar:
            homeRouter.showCalendar()
        }
    }
    
    // MARK: - Private
    
    func configureHomeDashboardViews() {
        // Profile
        let profileRow = HomeCellViewModel(view: ProfileDashboardView(), row: .profile)
        dataSource.append(profileRow)
        
        // CalendarDashboardView
        let calendarRow = HomeCellViewModel(view: CalendarDashboardView(), row: .calendar)
        dataSource.append(calendarRow)
    }
}
