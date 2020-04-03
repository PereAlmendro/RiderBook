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
    func select(tab: TabBarItem)
    
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func push(viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

public class BaseRouterImpl: BaseRouter {
    
    // MARK: - Properties
    
    private let RBTabbar: RBTabBarController
    var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }
    
    // MARK: - Lifecycle
    
    init() {
        let tabController = UITabBarController()
        RBTabbar = RBTabBarController(tabBarController: tabController)
    }
}
    
// MARK: - TabBar

extension BaseRouterImpl {
    func openHomeInitializingTabBar() {
        RBTabbar.configureTabs()
        present(viewController: RBTabbar.tabBarController, animated: true)
    }
    
    func select(tab: TabBarItem) {
        RBTabbar.selectTab(at: tab.rawValue)
    }
}
    
// MARK: - Present, Push, Dismiss

extension BaseRouterImpl {
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        topViewController?.present(viewController, animated: animated, completion: completion)
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        var viewController = viewController
        
        if let navigationController = UIApplication.topViewController()?.parent as? UINavigationController {
            if let viewControllerNVC = viewController as? UINavigationController,
                let lastViewController = viewControllerNVC.viewControllers.last {
                viewController = lastViewController
            }
            navigationController.pushViewController(viewController, animated: animated)
        } else {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController: viewController, animated: animated)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        topViewController?.dismiss(animated: true, completion: nil)
    }
}
