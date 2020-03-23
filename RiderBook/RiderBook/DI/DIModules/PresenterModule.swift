//
//  PresenterModule.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

class PresenterModule {
    static func setup(_ container: Container) {
        resolvePresenters(container)
    }
    
    static func resolvePresenters(_ container: Container) {
        container.register(LoginPresenter.self) { r in
            LoginPresenter(router: r.resolve(Router.self)!)
        }
    }}
