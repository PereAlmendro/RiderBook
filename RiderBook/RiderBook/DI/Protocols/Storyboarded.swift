//
//  Storyboarded.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import SwinjectStoryboard

protocol SwinjectResolved {
    static func instantiate() -> Self
}

extension SwinjectResolved where Self: UIViewController {
    static func instantiate() -> Self {
        return SwinjectStoryboard.defaultContainer.resolve(Self.self)!
    }
}
