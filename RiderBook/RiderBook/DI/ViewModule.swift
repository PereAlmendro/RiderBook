//
//  ViewAssembler.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

class ViewModule {
    static func setup(_ container: Container) {
        resolvePresenters(container)
        resolveViewControllers(container)
    }
    
    static func resolvePresenters(_ container: Container) {
        container.register(LoginPresenter.self) { _ in
            LoginPresenter()
        }
    }
    
    static func resolveViewControllers(_ container: Container) {
        container.register(LoginViewController.self) { r in
            let view = LoginViewController()
            view.presenter = r.resolve(LoginPresenter.self)!
            return view
        }
    }
}
