//
//  TabBarView.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

import SwiftUI

struct TabBarView: View {
    let homeView: HomeView
    let ridesView: RidesView
    let profileView: ProfileView
    
    var body: some View {
        TabView {
            homeView
                .tabItem {
                    Image("home_off")
                        .renderingMode(.template)
                        .foregroundColor(.dlBlack)
            }
            ridesView
                .tabItem {
                    Image("road_off")
                        .renderingMode(.template)
                        .foregroundColor(.dlBlack)
            }
            profileView
                .tabItem {
                    Image("profile_off")
                        .renderingMode(.template)
                        .foregroundColor(.dlBlack)
            }
        }
    }
}
