//
//  RouterModule.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

class RouterModule{
    static func setup(_ container: Container) {
        resolveRouter(container)
    }
    
    static func resolveRouter(_ container: Container) {
        container.register(Router.self) { _ in
            Router()
        }.inObjectScope(.container)
    }
}
