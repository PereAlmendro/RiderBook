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
    func present(vc: UIViewController, animated: Bool, completion: (() -> Void)?)
}

public class BaseRouterImpl: BaseRouter {
    
    private let RBTabbar: RBTabBarController
    var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }
    
    init() {
        let tabController = UITabBarController()
        RBTabbar = RBTabBarController(tabBarController: tabController)
    }
    
    func openHomeInitializingTabBar() {
        RBTabbar.configureTabs()
        present(vc: RBTabbar.tabBarController, animated: true)
    }
    
    func select(tab: TabItem) {
        RBTabbar.selectTab(at: tab.rawValue)
    }
    
    func present(vc: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        topViewController?.present(vc, animated: animated, completion: completion)
    }
    
}
