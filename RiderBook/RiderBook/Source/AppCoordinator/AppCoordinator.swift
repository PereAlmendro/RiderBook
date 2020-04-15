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
    func openHomeAfterLogin()
}

final class AppCoordinator: AppCoordinatorProtocol {

    private var window: UIWindow
    private var tabView: TabBarView?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let loginView = getLoginView()
        window.rootViewController = UIHostingController(rootView: loginView)
        window.makeKeyAndVisible()
    }
    
    func openHomeAfterLogin() {
        if tabView == nil {
            tabView = getTabBarView()
        }
        let hostingController = UIHostingController(rootView: tabView)
        hostingController.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(hostingController, animated: true, completion: nil)
    }
    
}

// MARK: - View builder

private extension AppCoordinator {
    
    func getLoginView() -> LoginView {
        let loginAssembly = LoginAssembly(coordinator: self)
        let loginView = loginAssembly.getView()
        return loginView
    }
    
    func getTabBarView() -> TabBarView {
        
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
