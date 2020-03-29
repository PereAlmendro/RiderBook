//
//  MyRidesPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class MyRidesPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let myRidesRouter: MyRidesRouter
    private let myRidesInteractor: MyRidesInteractor
    
    // MARK: - Lyfecycle
    
    init(myRidesRouter: MyRidesRouter, myRidesInteractor: MyRidesInteractor) {
        self.myRidesRouter = myRidesRouter
        self.myRidesInteractor = myRidesInteractor
    }
}
