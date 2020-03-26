//
//  BaseRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard

protocol BaseRouter {
    func openHomeInitializingTabBar()
    func select(tab: TabItem)
}

public class BaseRouterImpl: BaseRouter {
    
    private let RBTabbar: RBTabBarController
    
    init() {
        let tabController = UITabBarController()
        RBTabbar = RBTabBarController(tabBarController: tabController)
    }
    
    func openHomeInitializingTabBar() {
        RBTabbar.configureTabs()
        UIApplication
            .topViewController()?
            .present(RBTabbar.tabBarController,
                     animated: true,
                     completion: nil)
    }
    
    func select(tab: TabItem) {
        RBTabbar.selectTab(at: tab.rawValue)
    }
    
}
