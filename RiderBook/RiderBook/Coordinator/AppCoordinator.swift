//
//  AppCoordinator.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinator {
    var window: UIWindow? { get }
    func start(in window: UIWindow)
    
    // MARK: - TabBar Navigation
    
    func openHomeInitializingTabBar()
    func select(tab: TabBarItem)
    
    // MARK: - Navigations
    
    func dismiss()
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func showAddRide()
    func showDetail(of ride: Ride)
}

final class AppCoordinatorImpl: AppCoordinator {
    
    var window: UIWindow?

    private let RBTabbar: RBTabBarController
    var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }
    
    init() {
        let tabController = UITabBarController()
        RBTabbar = RBTabBarController(tabBarController: tabController)
    }
    
    func start(in window: UIWindow) {
        self.window = window
        let loginVC = LoginViewController.instantiate()
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
    }
    
}

// MARK: - TabBar Navigation

extension AppCoordinatorImpl {
    func openHomeInitializingTabBar() {
        RBTabbar.configureTabs()
        present(viewController: RBTabbar.tabBarController, animated: true)
    }
    
    func select(tab: TabBarItem) {
        RBTabbar.selectTab(at: tab.rawValue)
    }
}

// MARK: - Navigations

extension AppCoordinatorImpl {
    
    // MARK: - Dismiss
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        topViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Add Ride
    
    func showAddRide() {
        let addRideVC = AddRideViewController.instantiate()
        present(viewController: addRideVC,
                animated: true,
                completion: nil)
    }
    
    // MARK: - Ride Detail
    
    func showDetail(of ride: Ride) {
        let rideDetail = RideDetailViewController.instantiate()
        present(viewController: rideDetail,
                animated: true,
                completion: nil)
    }
}

// MARK: - Present, push, dimiss

extension AppCoordinatorImpl {
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
}
