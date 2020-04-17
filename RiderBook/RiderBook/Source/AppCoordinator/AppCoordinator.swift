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
    func openHomeAfterLogin()
}

final class AppCoordinator: AppCoordinatorProtocol {

    private var window: UIWindow
    private var tabView: TabBarView?
    private var localRepository: LocalRepositoryProtocol
    private var loginService: LoginServiceProtocol
    
    init(window: UIWindow,
         localRepository: LocalRepositoryProtocol,
         loginService: LoginServiceProtocol) {
        self.window = window
        self.localRepository = localRepository
        self.loginService = loginService
    }
    
    func start() {
        if let user = localRepository.getUser() {
            _ = loginService
                .logIn(email: user.email, password: user.password, encodedPassword: true)
                .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                .subscribeOn(MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] (user) in
                    DispatchQueue.main.async {
                        if user?.authorization != nil {
                            self?.openHome()
                        } else {
                            self?.openLogin()
                        }
                    }
                }) { [weak self] (error) in
                    self?.openLogin()
            }
        } else {
            openLogin()
        }
    }
    
    private func openLogin() {
        let loginView = getLoginView()
        window.rootViewController = UIHostingController(rootView: loginView)
        window.makeKeyAndVisible()
    }
    
    private func openHome() {
        let tabView = getTabBarView()
        window.rootViewController = UIHostingController(rootView: tabView)
        window.makeKeyAndVisible()
    }
    
}

// MARK: - Navigations

extension AppCoordinator {
    
    func openHomeAfterLogin() {
        let tabView = getTabBarView()
        let hostingController = UIHostingController(rootView: tabView)
        hostingController.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(hostingController, animated: true, completion: nil)
    }
    
}

// MARK: - View builder

private extension AppCoordinator {
    
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
