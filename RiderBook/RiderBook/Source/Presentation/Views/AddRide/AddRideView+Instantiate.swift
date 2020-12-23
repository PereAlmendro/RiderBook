//
//  AddRideView+Instantiate.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

extension AddRideView {
    static func instantiate() -> AddRideView {
        let viewModel = AddRideViewModel()
        return AddRideView(viewModel: viewModel)
    }
}
