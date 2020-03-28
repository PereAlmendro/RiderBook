//
//  BaseView.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol BaseView: AnyObject {
    
    // MARK: - Alert
    
    func showAlert(type: AlertType, title: String?, message: String?, completion: (() -> ())?)

    // MARK: - Loader
    
    func showLoader()
    func hideLoader()
}
