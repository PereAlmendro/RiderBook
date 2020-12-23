//
//  TabBarView+Instantiate.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import SwiftUI

extension TabBarView {
    static func instantiate(title: String = "") -> TabBarView {
        return TabBarView(homeView: HomeView.instantiate(title: title),
                          ridesView: RidesView.instantiate(),
                          profileView: ProfileView.instantiate())
    }
}
