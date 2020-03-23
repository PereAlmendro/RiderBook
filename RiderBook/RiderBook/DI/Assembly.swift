//
//  ViewModule.swift
//  NewBershka
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Swinject

protocol Assembly {
    func assemble(container: Container)
}
