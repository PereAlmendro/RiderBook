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

protocol AppCoordinatorProtocol: AnyObject {
    /// Called in the scene delegate, shows login after the launchScreen
    func start()
    
    // Screens
    func showHome()
    func showLogin()
    func showRegister()
    func showAddRide()
    func showEditRide(for ride: Ride)
    func showRideDetail(for ride: Ride)
    
    func dismiss()
    func showAlert(alert: UIAlertController)
}

final class AppCoordinator: AppCoordinatorProtocol {

    private var window: UIWindow
    private var viewAssembly: ViewAssemblyProtocol!
    private var tabView: TabBarView?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        loadApplication()

        let splashView = viewAssembly.getSplashView()
        window.rootViewController = UIHostingController(rootView: splashView)
        window.makeKeyAndVisible()
    }

    private func loadApplication() {
        viewAssembly = getViewAssembly()
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
        let loginView = viewAssembly.getLoginView()
        let hostingController = UIHostingController(rootView: loginView)
        let navController = UINavigationController(rootViewController: hostingController)
        navController.modalPresentationStyle = .fullScreen
        present(viewController: navController, animated: true)
    }
    
    func showRegister() {
        let registerView = viewAssembly.getRegisterView()
        let hostingController = UIHostingController(rootView: registerView)
        push(viewController: hostingController, animated: true)
    }
    
    func showAddRide() {
        let addRideView = viewAssembly.getAddEditRideView(mode: .add, ride: nil)
        let hostingController = UIHostingController(rootView: addRideView)
        present(viewController: hostingController, animated: true)
    }
    
    func showEditRide(for ride: Ride) {
        let addRideView = viewAssembly.getAddEditRideView(mode: .edit, ride: ride)
        let hostingController = UIHostingController(rootView: addRideView)
        present(viewController: hostingController, animated: true)
    }
    
    func showRideDetail(for ride: Ride) {
        let detailView = viewAssembly.getRideDetailView(for: ride)
        let hostingController = UIHostingController(rootView: detailView)
        let navController = UINavigationController(rootViewController: hostingController)
        navController.modalPresentationStyle = .fullScreen
        present(viewController: navController, animated: true)
    }
    
    func dismiss() {
        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(alert: UIAlertController) {
        present(viewController: alert, animated: true)
    }
    
}

// MARK: - Private functions

private extension AppCoordinator {
    
    private func getTabBarView() -> TabBarView? {
        
        if let tabView = tabView {
            return tabView
        }
        
        let homeView = viewAssembly.getHomeView()
        let ridesView = viewAssembly.getRidesView()
        let profileView = viewAssembly.getProfileView()
        
        return TabBarView(homeView: homeView,
                          ridesView: ridesView,
                          profileView: profileView)
    }
    
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
    
    private func getViewAssembly() -> ViewAssemblyProtocol {
        let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let apiServiceAssembly = ApiServiceAssembly()
        let repositoryAssembly = RepositoryAssembly(coreDataContext: coreDataContext,
                                                    apiServiceAssembly: apiServiceAssembly)
        let serviceAssembly = ServiceAssembly(repositoryAssembly: repositoryAssembly)
        return ViewAssembly(coordinator: self, serviceAssembly: serviceAssembly)
    }
}
