//
//  Screen.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

public class Screen: NSObject {
    private let viewController: UIViewController
    private let isModal: Bool
    private let animated: Bool
    
    init(viewController: UIViewController, isModal: Bool = false, animated: Bool = true) {
        self.viewController = viewController
        self.isModal = isModal
        self.animated = animated
    }
    
    public func get() -> UIViewController {
        return viewController
    }
    
    public func show(animated: Bool = true) {
        let isAnimated = animated
        if isModal {
            presentViewController(viewController, animated: isAnimated)
        } else {
            pushViewController(viewController, animated: isAnimated)
        }
    }
    
    // MARK: - Present Methods
    
    private func presentViewController(_ viewController: UIViewController, animated: Bool) {
        UIApplication.topViewController()?.present(viewController, animated: animated, completion: nil)
    }
    
    // MARK: - Push Methods
    
    private func pushViewController(_ viewController: UIViewController, animated: Bool) {
        var viewController = viewController
        // Push if there is a Navigation Controller
        if let navigationController = UIApplication.topViewController()?.parent as? UINavigationController {
            // Get the last VC if it is inside of a stack
            if let viewControllerNVC = viewController as? UINavigationController,
                let lastViewController = viewControllerNVC.viewControllers.last {
                viewController = lastViewController
            }
            navigationController.pushViewController(viewController, animated: animated)
        } else { // If not, Present
            presentViewController(viewController, animated: animated)
        }
    }
}
