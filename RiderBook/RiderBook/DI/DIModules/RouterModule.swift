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

        // MARK: - BaseRouter

        container.register(BaseRouter.self) { _ in
            BaseRouterImpl()
        }.inObjectScope(.container)
        
        // MARK: - Login

        container.register(LoginRouter.self) { r in
            LoginRouterImpl(baseRouter: r.resolve(BaseRouter.self)!)
        }
        
        // MARK: - Home

        container.register(HomeRouter.self) { r in
            HomeRouterImpl(baseRouter: r.resolve(BaseRouter.self)!)
        }
        
        // MARK: - Profile
        
        container.register(ProfileRouter.self) { r in
            ProfileRouterImpl(baseRouter: r.resolve(BaseRouter.self)!)
        }
        
        // MARK: - Calendar
        
        container.register(CalendarRouter.self) { r in
            CalendarRouterImpl(baseRouter: r.resolve(BaseRouter.self)!)
        }
        
        container.register(AddRideRouter.self) { r in
            AddRideRouterImpl(baseRouter: r.resolve(BaseRouter.self)!)
        }
    }
}
