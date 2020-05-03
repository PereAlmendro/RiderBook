//
//  Assembler.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

protocol AppCoordinatorProtocol {
    /// Called in the scene delegate, shows login after the launchScreen
    func start()
    func showHome()
    func showLogin()
    func showRegister()
    func showAddRide()
    func showRideDetail(for ride: Ride)
}

final class AppCoordinator: AppCoordinatorProtocol {

    private var window: UIWindow
    private var tabView: TabBarView?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let splashView = getSplashView()
        window.rootViewController = UIHostingController(rootView: splashView)
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private functions
    
    private func push(viewController: UIViewController, animated: Bool) {
        var viewController = viewController
        if let navigationController = UIApplication.topViewController()?.parent as? UINavigationController {
            if let viewControllerNVC = viewController as? UINavigationController,
                let lastViewController = viewControllerNVC.viewControllers.last {
                viewController = lastViewController
            }
            navigationController.pushViewController(viewController, animated: animated)
        } else {
            present(viewController: viewController, animated: animated)
        }
    }
    
    private func present(viewController: UIViewController, animated: Bool) {
        UIApplication.topViewController()?.present(viewController, animated: animated, completion: nil)
    }
}

// MARK: - Navigations

extension AppCoordinator {
    
    func showHome() {
        let tabView = getTabBarView()
        let hostingController = UIHostingController(rootView: tabView)
        hostingController.modalPresentationStyle = .fullScreen
        present(viewController: hostingController, animated: true)
    }
    
    func showLogin() {
        let loginView = getLoginView()
        let hostingController = UIHostingController(rootView: loginView)
        let navController = UINavigationController(rootViewController: hostingController)
        navController.modalPresentationStyle = .fullScreen
        present(viewController: navController, animated: true)
    }
    
    func showRegister() {
        let registerView = getRegisterView()
        let hostingController = UIHostingController(rootView: registerView)
        push(viewController: hostingController, animated: true)
    }
    
    func showAddRide() {
        let addRideView = getAddRideView()
        let hostingController = UIHostingController(rootView: addRideView)
        present(viewController: hostingController, animated: true)
    }
    
    func showRideDetail(for ride: Ride) {
        let detailView = getRideDetailView(for: ride)
        let hostingController = UIHostingController(rootView: detailView)
        present(viewController: hostingController, animated: true)
    }
    
}

// MARK: - View builder

private extension AppCoordinator {
    
    private func getRideDetailView(for ride: Ride) -> RideDetailView {
        let rideDetailAssembly = RideDetailAssembly(coordinator: self)
        let rideDetailView = rideDetailAssembly.getView(for: ride)
        return rideDetailView
    }
    
    private func getAddRideView() -> AddRideView {
        let addRideAssembly = AddRideAssembly(coordinator: self)
        let addRideView = addRideAssembly.getView()
        return addRideView
    }
    
    private func getRegisterView() -> RegisterView {
        let registerAssembly = RegisterAssembly(coordinator: self)
        let registerView = registerAssembly.getView()
        return registerView
    }
    
    private func getSplashView() -> SplashView {
        let splashAssembly = SplashAssembly(coordinator: self)
        let splashView = splashAssembly.getView()
        return splashView
    }
    
    private func getLoginView() -> LoginView {
        let loginAssembly = LoginAssembly(coordinator: self)
        let loginView = loginAssembly.getView()
        return loginView
    }
    
    private func getTabBarView() -> TabBarView {
        
        if let tabView = tabView {
            return tabView
        }
        
        let homeAssembly = HomeAssembly(coordinator: self)
        let homeView = homeAssembly.getView()
        
        let ridesAssembly = RidesAssembly(coordinator: self)
        let ridesView = ridesAssembly.getView()
        
        let profileAssembly = ProfileAssembly(coordinator: self)
        let profileView = profileAssembly.getView()
        
        return TabBarView(homeView: homeView,
                          ridesView: ridesView,
                          profileView: profileView)
    }
}
