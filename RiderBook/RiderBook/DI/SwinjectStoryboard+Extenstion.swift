//
//  ViewModule.swift
//  NewBershka
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwinjectStoryboard

public extension SwinjectStoryboard {
    class func setup() {
        RouterModule.setup(defaultContainer)
        PresenterModule.setup(defaultContainer)
        ViewControllerModule.setup(defaultContainer)
    }
}
