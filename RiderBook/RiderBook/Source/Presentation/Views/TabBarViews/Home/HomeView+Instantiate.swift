//
//  HomeView+Instantiate.swift
//  RiderBook
//
//  Created by Pere Almendro on 20/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

extension HomeView {
    static func instantiate(title: String) -> HomeView {
        let homeViewModel = HomeViewModel(title: title)
        return HomeView(viewModel: homeViewModel)
    }
}
