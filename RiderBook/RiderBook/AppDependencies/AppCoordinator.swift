//
//  AppCoordinator.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import SwiftUI

final class AppCoordinator {
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let splashView = UIHostingController(rootView: SplashView.instantiate())
        let navController = UINavigationController(rootViewController: splashView)

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }

    static func restartApp() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.appCoordinator?.start()
    }
}
