//
//  BaseRouter.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard

protocol BaseRouter {
    var coordinator: AppCoordinator? { get }
    init(coordinator: AppCoordinator)
}
