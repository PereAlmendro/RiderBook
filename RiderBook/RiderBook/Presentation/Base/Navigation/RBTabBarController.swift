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
    case profile
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
    
    func configureTabs() {
        // HomeViewController
        let homeVC = SwinjectStoryboard.defaultContainer.resolve(HomeViewController.self)!
        homeVC.modalPresentationStyle = .fullScreen
        
        let homeTabItem = UITabBarItem(title: String(),
                                   image: UIImage(named: "home_off")?.withRenderingMode(.alwaysOriginal),
                                   selectedImage: UIImage(named: "home_on")?.withRenderingMode(.alwaysOriginal))
        homeVC.tabBarItem = homeTabItem
        
        // ProfileViewController
        let profileVC = SwinjectStoryboard.defaultContainer.resolve(ProfileViewController.self)!
        profileVC.modalPresentationStyle = .fullScreen
        
        let profileTabItem = UITabBarItem(title: String(),
                                   image: UIImage(named: "profile_off")?.withRenderingMode(.alwaysOriginal),
                                   selectedImage: UIImage(named: "profile_on")?.withRenderingMode(.alwaysOriginal))
        profileVC.tabBarItem = profileTabItem
        
        // Set ViewControllers
        tabBarController.setViewControllers([homeVC, profileVC], animated: false)
        
        // Set defaults
        tabBarController.selectedViewController = homeVC
        tabBarController.modalPresentationStyle = .fullScreen
    }
}
