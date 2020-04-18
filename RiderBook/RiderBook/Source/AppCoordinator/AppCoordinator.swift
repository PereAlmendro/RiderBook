//
//  Assembler.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI
import RxSwift
import UIKit

protocol AppCoordinatorProtocol {
    /// Called in the scene delegate, shows login after the launchScreen
    func start()
    func showHome()
    func showLogin()
    func showRegister()
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
    
}

// MARK: - Navigations

extension AppCoordinator {
    
    func showHome() {
        let tabView = getTabBarView()
        let hostingController = UIHostingController(rootView: tabView)
        hostingController.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(hostingController, animated: true, completion: nil)
    }
    
    func showLogin() {
        let loginView = getLoginView()
        let hostingController = UIHostingController(rootView: loginView)
        hostingController.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(hostingController, animated: false, completion: nil)
    }
    
    func showRegister() {
        
    }
    
}

// MARK: - View builder

private extension AppCoordinator {
    
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
