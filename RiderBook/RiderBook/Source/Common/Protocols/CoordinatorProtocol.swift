//
//  CoordinatorProtocol.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
