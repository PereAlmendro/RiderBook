//
//  homePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: BasePresenter {
    
    private let homeRouter: HomeRouter
    var dataSource: [UIView] = []
    
    init(homeRouter: HomeRouter) {
        self.homeRouter = homeRouter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Profile
        let profileDashboardView = ProfileDashboardView()
        dataSource.append(profileDashboardView)
        
        // CalendarDashboardView
        let calendarDashboardView = CalendarDashboardView()
        dataSource.append(calendarDashboardView)
        
    }
}
