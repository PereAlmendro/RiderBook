//
//  RBTabBarController.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import SwinjectStoryboard

public enum TabItem: Int {
    case home
}

public class RBTabBarController: NSObject, UITabBarControllerDelegate {
    
    let tabBarController: UITabBarController
    
    var selectedViewController: UIViewController? {
        return tabBarController.selectedViewController
    }
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        super.init()
    }
    
    func selectTab(tab: TabItem) {
        tabBarController.selectedIndex = tab.rawValue
    }
    
    func configureTabs() {
        // HomeViewController
        let homeVC = SwinjectStoryboard.defaultContainer.resolve(HomeViewController.self)!
        homeVC.modalPresentationStyle = .fullScreen
        let tabItem = UITabBarItem(title: "HOME", image: nil, selectedImage: nil)
        homeVC.tabBarItem = tabItem
        
        // Set ViewControllers
        tabBarController.setViewControllers([homeVC], animated: false)
        
        // Set defaults
        tabBarController.selectedViewController = homeVC
        tabBarController.modalPresentationStyle = .fullScreen
    }
}
