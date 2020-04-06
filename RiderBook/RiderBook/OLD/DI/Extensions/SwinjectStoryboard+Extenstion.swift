//
//  SwinjectStoryboard+Extenstion.swift
//  NewBershka
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        RouterDIModule.setup(defaultContainer)
        InteractorDIModule.setup(defaultContainer)
        PresenterDIModule.setup(defaultContainer)
        ViewControllerDIModule.setup(defaultContainer)
    }
}
