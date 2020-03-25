//
//  homePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class HomePresenter: BasePresenter {
    
    private let homeRouter: HomeRouter
    
    init(homeRouter: HomeRouter) {
        self.homeRouter = homeRouter
    }
        
}
